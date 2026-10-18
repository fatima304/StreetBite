import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/meal_model.dart';
import '../../data/repositories/favourites_repository.dart';

class FavouritesState {
  const FavouritesState({
    this.meals = const [],
    this.loading = true,
    this.error,
  });
  final List<MealModel> meals;
  final bool loading;
  final String? error;
  bool contains(String id) => meals.any((meal) => meal.id == id);
}

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit(this._repository, this._auth)
    : super(const FavouritesState()) {
    _authSubscription = _auth.authStateChanges().listen(_onAuthChanged);
    _onAuthChanged(_auth.currentUser);
  }
  final FavouritesRepository _repository;
  final FirebaseAuth _auth;
  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<List<MealModel>>? _subscription;
  String? _activeUid;
  int _generation = 0;

  // Check that a Firestore update belongs to the current account.
  bool _isCurrentUser(int generation) => !isClosed && generation == _generation;
  final Set<String> _pending = {};

  void _onAuthChanged(User? user) {
    final uid = user?.uid;
    if (_activeUid == uid && _subscription != null) {
      return;
    }
    _activeUid = uid;
    final generation = ++_generation;
    _subscription?.cancel();
    _subscription = null;
    _pending.clear();
    if (uid == null) {
      if (!isClosed) emit(const FavouritesState(meals: [], loading: false));
      return;
    }
    if (!isClosed) emit(const FavouritesState());
    _subscription = _repository
        .watchFor(uid)
        .listen(
          (meals) {
            if (_isCurrentUser(generation)) {
              emit(FavouritesState(meals: meals, loading: false));
            }
          },
          onError: (Object error) {
            if (_isCurrentUser(generation)) {
              emit(
                FavouritesState(
                  meals: state.meals,
                  loading: false,
                  error: 'loadFavourites',
                ),
              );
            }
          },
        );
  }

  Future<void> toggle(MealModel meal) async {
    if (_activeUid == null || state.loading || !_pending.add(meal.id)) {
      return;
    }
    try {
      if (state.contains(meal.id)) {
        await _repository.remove(meal.id);
      } else {
        await _repository.save(meal);
      }
    } catch (_) {
      if (!isClosed) {
        emit(
          FavouritesState(
            meals: state.meals,
            loading: false,
            error: 'updateFavourites',
          ),
        );
      }
    } finally {
      _pending.remove(meal.id);
    }
  }

  @override
  Future<void> close() async {
    ++_generation;
    await _authSubscription?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}

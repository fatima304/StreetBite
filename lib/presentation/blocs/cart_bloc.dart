import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/cart_repository.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.repository, FirebaseAuth auth)
    : super(const CartState(loading: true)) {
    on<CartAccountChanged>(_onAccountChanged);
    on<CartLoaded>((event, emit) {
      if (event.uid != _uid) return;
      emit(
        CartState(
          items: List.unmodifiable(event.items),
          revision: state.revision + 1,
        ),
      );
    });
    on<CartAdd>((event, emit) {
      if (event.quantity < 1 || state.loading) return;
      final items = [...state.items];
      final index = items.indexWhere((e) => e.meal.id == event.meal.id);
      if (index < 0) {
        items.add(CartItem(meal: event.meal, quantity: event.quantity));
      } else {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity + event.quantity,
        );
      }
      _update(items, emit);
    });
    on<CartIncrease>((event, emit) => _change(event.mealId, 1, emit));
    on<CartDecrease>((event, emit) => _change(event.mealId, -1, emit));
    on<CartRemove>(
      (event, emit) => _update(
        state.items.where((e) => e.meal.id != event.mealId).toList(),
        emit,
      ),
    );
    on<CartClear>((event, emit) => _update([], emit, persist: false));
    _authSub = auth.authStateChanges().listen(
      (user) => add(CartAccountChanged(user?.uid)),
    );
  }

  final CartRepository repository;
  late final StreamSubscription<User?> _authSub;
  String? _uid;
  // Save cart changes in order so a slower write cannot overwrite a newer one.
  Future<void> _writeQueue = Future.value();

  Future<void> _onAccountChanged(
    CartAccountChanged event,
    Emitter<CartState> emit,
  ) async {
    if (_uid == event.uid && !state.loading) return;
    _uid = event.uid;
    emit(CartState(revision: state.revision + 1, loading: event.uid != null));
    if (event.uid == null) return;
    try {
      final items = await repository.load(event.uid!);
      if (event.uid == _uid) add(CartLoaded(event.uid!, items));
    } catch (e) {
      if (event.uid == _uid) emit(CartState(error: 'loadCart'));
    }
  }

  void _change(String id, int amount, Emitter<CartState> emit) {
    if (state.loading) return;
    final items = [...state.items];
    final i = items.indexWhere((e) => e.meal.id == id);
    if (i < 0) return;
    final next = items[i].quantity + amount;
    if (next <= 0) {
      items.removeAt(i);
    } else {
      items[i] = items[i].copyWith(quantity: next);
    }
    _update(items, emit);
  }

  void _update(
    List<CartItem> items,
    Emitter<CartState> emit, {
    bool persist = true,
  }) {
    if (state.loading) return;
    final uid = _uid;
    emit(
      CartState(items: List.unmodifiable(items), revision: state.revision + 1),
    );
    if (!persist || uid == null) return;
    final snapshot = List<CartItem>.from(items);
    _writeQueue = _writeQueue
        .catchError((Object _) {})
        .then((_) => _saveCart(uid, snapshot));
  }

  Future<void> _saveCart(String uid, List<CartItem> items) async {
    if (_uid == uid) {
      await repository.save(uid, items);
    }
  }

  /// Wait for queued cart writes before committing an order.
  Future<void> waitForWrites() => _writeQueue;

  @override
  Future<void> close() async {
    await _authSub.cancel();
    await _writeQueue.catchError((Object _) {});
    return super.close();
  }
}

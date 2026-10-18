import '../../core/errors/error_codes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;
  int _request = 0;

  // Ignore results from an older category request.
  bool _isOldRequest(int request) => isClosed || request != _request;
  HomeCubit(this.repository) : super(const HomeState());

  Future<void> load() async {
    final request = ++_request;
    emit(
      HomeState(
        loading: true,
        categories: state.categories,
        meals: state.meals,
        selectedCategory: state.selectedCategory,
        offers: state.offers,
      ),
    );
    try {
      final categories = await repository.getCategories();
      final meals = await repository.getMeals();
      if (_isOldRequest(request)) {
        return;
      }
      emit(
        HomeState(
          categories: categories,
          meals: meals,
          offers: meals.take(5).toList(),
        ),
      );
    } catch (error) {
      if (_isOldRequest(request)) {
        return;
      }
      emit(
        HomeState(
          categories: state.categories,
          meals: state.meals,
          error: ErrorCodes.forMeals(error),
          offers: state.offers,
        ),
      );
    }
  }

  Future<void> selectCategory(String? category) async {
    if (category == state.selectedCategory &&
        !state.loading &&
        state.error == null) {
      return;
    }
    final request = ++_request;
    emit(
      HomeState(
        loading: true,
        categories: state.categories,
        meals: state.meals,
        selectedCategory: category,
        offers: state.offers,
      ),
    );
    try {
      final meals = await repository.getMeals(category: category);
      if (_isOldRequest(request)) {
        return;
      }
      emit(
        HomeState(
          categories: state.categories,
          meals: meals,
          selectedCategory: category,
          offers: state.offers,
        ),
      );
    } catch (error) {
      if (_isOldRequest(request)) {
        return;
      }
      emit(
        HomeState(
          categories: state.categories,
          meals: state.meals,
          selectedCategory: category,
          error: ErrorCodes.forMeals(error),
          offers: state.offers,
        ),
      );
    }
  }
}

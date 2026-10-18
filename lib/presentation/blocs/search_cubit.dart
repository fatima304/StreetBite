import '../../core/errors/error_codes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/home_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._repository) : super(const SearchState());
  final HomeRepository _repository;
  int _requestId = 0;

  // Only the latest search/filter result should update the screen.
  bool _isOldRequest(int id) => isClosed || id != _requestId;

  Future<void> load() async {
    final requestId = ++_requestId;
    emit(
      SearchState(
        categories: state.categories,
        areas: state.areas,
        meals: state.meals,
        loading: true,
      ),
    );
    try {
      final categories = await _repository.getCategories();
      if (_isOldRequest(requestId)) return;
      emit(SearchState(categories: categories));
    } catch (error) {
      if (_isOldRequest(requestId)) return;
      emit(
        SearchState(
          categories: state.categories,
          areas: state.areas,
          meals: state.meals,
          error: ErrorCodes.forMeals(error),
        ),
      );
    }
  }

  Future<void> search(String text) async {
    final query = text.trim();
    if (query.isEmpty) {
      await load();
      return;
    }
    final requestId = ++_requestId;
    emit(
      SearchState(
        categories: state.categories,
        areas: state.areas,
        meals: state.meals,
        query: query,
        loading: true,
      ),
    );
    try {
      final meals = await _repository.searchMeals(query);
      if (_isOldRequest(requestId)) return;
      emit(
        SearchState(
          categories: state.categories,
          areas: state.areas,
          meals: meals,
          query: query,
        ),
      );
    } catch (error) {
      if (_isOldRequest(requestId)) return;
      emit(
        SearchState(
          categories: state.categories,
          areas: state.areas,
          query: query,
          error: ErrorCodes.forMeals(error),
        ),
      );
    }
  }

  Future<void> selectCategory(String category) async {
    final requestId = ++_requestId;
    emit(
      SearchState(
        categories: state.categories,
        areas: state.areas,
        selectedCategory: category,
        loading: true,
      ),
    );
    try {
      final meals = await _repository.getMeals(category: category);
      if (_isOldRequest(requestId)) return;
      emit(
        SearchState(
          categories: state.categories,
          areas: state.areas,
          meals: meals,
          selectedCategory: category,
        ),
      );
    } catch (error) {
      if (_isOldRequest(requestId)) return;
      emit(
        SearchState(
          categories: state.categories,
          areas: state.areas,
          selectedCategory: category,
          error: ErrorCodes.forMeals(error),
        ),
      );
    }
  }

  Future<void> selectArea(String area) async {
    final requestId = ++_requestId;
    emit(
      SearchState(
        categories: state.categories,
        areas: state.areas,
        selectedArea: area,
        loading: true,
      ),
    );
    try {
      final meals = await _repository.getMealsByArea(area);
      if (_isOldRequest(requestId)) return;
      emit(
        SearchState(
          categories: state.categories,
          areas: state.areas,
          selectedArea: area,
          meals: meals,
        ),
      );
    } catch (error) {
      if (_isOldRequest(requestId)) return;
      emit(
        SearchState(
          categories: state.categories,
          areas: state.areas,
          selectedArea: area,
          error: ErrorCodes.forMeals(error),
        ),
      );
    }
  }
}

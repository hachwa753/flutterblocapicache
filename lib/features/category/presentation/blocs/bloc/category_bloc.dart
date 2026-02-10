import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';
import 'package:flutterapiecommerce/features/category/domain/repo/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo repo;
  CategoryBloc(this.repo) : super(CategoryState()) {
    on<FetchAllCategories>(_fetchAllCategories);
  }

  void _fetchAllCategories(
    FetchAllCategories event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final cachedCategories = repo.cachedCaetgories();
      if (cachedCategories.isNotEmpty) {
        emit(
          state.copyWith(
            categories: cachedCategories,
            categoryStatus: CategoryStatus.loaded,
          ),
        );
      } else {
        emit(state.copyWith(categoryStatus: CategoryStatus.loading));
      }
      final categories = await repo.fetchAllCategories();

      //merge with cache to prevent duplicates
      final mergedCategories = [
        ...cachedCategories,
        ...categories.where(
          (category) =>
              !cachedCategories.any((cached) => cached.slug == cached.slug),
        ),
      ];
      emit(
        state.copyWith(
          categories: mergedCategories,
          categoryStatus: CategoryStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.failure,
          msz: "Categories error failed",
        ),
      );
    }
  }
}

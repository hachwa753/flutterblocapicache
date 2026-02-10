// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, loaded, failure }

class CategoryState extends Equatable {
  final CategoryStatus categoryStatus;
  final List<Categories> categories;
  final String? msz;
  const CategoryState({
    this.categoryStatus = CategoryStatus.initial,
    this.categories = const [],
    this.msz,
  });

  @override
  List<Object?> get props => [categories, categoryStatus, msz];

  CategoryState copyWith({
    CategoryStatus? categoryStatus,
    List<Categories>? categories,
    String? msz,
  }) {
    return CategoryState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
      msz: msz ?? this.msz,
    );
  }
}

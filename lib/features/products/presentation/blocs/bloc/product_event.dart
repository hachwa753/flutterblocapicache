part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchAllProducts extends ProductEvent {}

class LoadMoreProducts extends ProductEvent {}

class GetProductsByCat extends ProductEvent {
  final String catName;

  const GetProductsByCat(this.catName);
}

class GetProductsByQuery extends ProductEvent {
  final String query;

  const GetProductsByQuery(this.query);
}

class ClearSearch extends ProductEvent {
  const ClearSearch();
}

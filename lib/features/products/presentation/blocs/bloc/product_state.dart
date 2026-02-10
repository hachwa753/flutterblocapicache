// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, loading, loaded, failure }

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final List<Product> product;
  final ProductStatus productByCatStatus;
  final List<Product> productByCat;
  final ProductStatus productByQueryStatus;
  final List<Product> productByQuery;
  final String? msz;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const ProductState({
    this.productStatus = ProductStatus.initial,
    this.product = const [],
    this.productByCat = const [],
    this.productByQuery = const [],
    this.msz,
    this.productByCatStatus = ProductStatus.initial,
    this.productByQueryStatus = ProductStatus.initial,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [
    productStatus,
    productByCatStatus,
    product,
    msz,
    productByCat,
    productByCatStatus,
    productByQuery,
    hasReachedMax,
    isLoadingMore,
  ];

  ProductState copyWith({
    ProductStatus? productStatus,
    List<Product>? product,
    ProductStatus? productByCatStatus,
    List<Product>? productByCat,
    ProductStatus? productByQueryStatus,
    List<Product>? productByQuery,
    String? msz,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      product: product ?? this.product,
      productByCatStatus: productByCatStatus ?? this.productByCatStatus,
      productByCat: productByCat ?? this.productByCat,
      productByQueryStatus: productByQueryStatus ?? this.productByQueryStatus,
      productByQuery: productByQuery ?? this.productByQuery,
      msz: msz ?? this.msz,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

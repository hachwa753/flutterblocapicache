import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:flutterapiecommerce/features/products/domain/repo/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo repo;

  int page = 0;
  final int limit = 10;

  ProductBloc(this.repo) : super(ProductState()) {
    on<FetchAllProducts>(_fetchAllProducts);
    on<LoadMoreProducts>(_loadMoreProducts);
    on<GetProductsByCat>(_fetchProductsByCategory);
    on<GetProductsByQuery>(_fetchProductsByQuery);
    on<ClearSearch>(_clearSearch);
  }

  void _fetchAllProducts(
    FetchAllProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      //  page = 0;
      // emit cached products instantly
      final cachedProducts = repo.getCachedProducts();
      if (cachedProducts.isNotEmpty) {
        emit(
          state.copyWith(
            product: cachedProducts,
            productStatus: ProductStatus.loaded,
          ),
        );
        // page offset based on cacched length
        page = cachedProducts.length;
      } else {
        emit(state.copyWith(productStatus: ProductStatus.loading));
        page = 0;
      }

      final products = await repo.fetchAllproducts(page, limit);
      final mergedProducts = [
        ...cachedProducts,
        ...products.where(
          (product) => !cachedProducts.any((c) => c.id == product.id),
        ),
      ];
      emit(
        state.copyWith(
          productStatus: ProductStatus.loaded,
          product: mergedProducts,
          hasReachedMax: products.length < limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productStatus: ProductStatus.failure,
          msz: "Failed to load products from api",
        ),
      );
    }
  }

  void _loadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state.hasReachedMax || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    page = state.product.length;
    log(page.toString());
    try {
      // await Future.delayed(Duration(seconds: 5));
      final products = await repo.fetchAllproducts(page, limit);
      // merge while avoiding duplicates
      final newProducts = products.where(
        (p) => !state.product.any((e) => e.id == p.id),
      );
      //final allProducts = List<Product>.from(state.product)..addAll(products);
      final updatedProducts = [...state.product, ...newProducts];
      emit(
        state.copyWith(
          productStatus: ProductStatus.loaded,
          product: updatedProducts,
          isLoadingMore: false,
          hasReachedMax: newProducts.isEmpty || products.length < limit,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productStatus: ProductStatus.failure,
          msz: "Failed to load products from api",
          isLoadingMore: false,
        ),
      );
    }
  }

  void _fetchProductsByCategory(
    GetProductsByCat event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productByCatStatus: ProductStatus.loading));
    try {
      final products = await repo.fetchProductsByCategory(event.catName);

      emit(
        state.copyWith(
          productByCat: products,
          productByCatStatus: ProductStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productByCatStatus: ProductStatus.failure,
          msz: "Failed to load products",
        ),
      );
    }
  }

  void _fetchProductsByQuery(
    GetProductsByQuery event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productByQueryStatus: ProductStatus.loading));

    try {
      final products = await repo.searchProducts(event.query);
      emit(
        state.copyWith(
          productByQuery: products,
          productByQueryStatus: ProductStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          msz: "Failed to load products",
          productByQueryStatus: ProductStatus.failure,
        ),
      );
    }
  }

  void _clearSearch(ClearSearch event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        productByQuery: [],
        productByQueryStatus: ProductStatus.initial,
      ),
    );
  }
}

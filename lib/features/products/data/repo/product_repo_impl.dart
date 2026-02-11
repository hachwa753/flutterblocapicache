import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutterapiecommerce/features/products/data/source/api_source.dart';
import 'package:flutterapiecommerce/features/products/data/source/local_source.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:flutterapiecommerce/features/products/domain/repo/product_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepo)
class ProductRepoImpl extends ProductRepo {
  final LocalSource localSource;
  final ApiSource apiSource;

  ProductRepoImpl(this.apiSource, this.localSource);
  @override
  Future<Either<String, List<Product>>> fetchAllproducts(
    int page,
    int limit,
  ) async {
    final cachedProducts = localSource.getCachedProducts();
    if (page == 0 && cachedProducts.isNotEmpty) {
      //background update
      // ignore: body_might_complete_normally_catch_error
      _fetchProducts(page, limit).catchError((error) {
        log("Background refresh failed: $error");
      });
      // log("Cached length: ${updated.length}");
      return Right(cachedProducts);
    }
    try {
      return Right(await _fetchProducts(page, limit));
    } catch (e) {
      final cached = localSource.getCachedProducts();
      if (cached.isNotEmpty) {
        return Right(cached);
      }
      return Left("Offline and no cached data");
    }
  }

  @override
  Future<Either<String, List<Product>>> fetchProductsByCategory(
    String catName,
  ) async {
    try {
      return Right(await apiSource.getProductsByCategory(catName));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> searchProducts(String query) async {
    try {
      return Right(await apiSource.getProductsByQuery(query));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<List<Product>> _fetchProducts(int page, int limit) async {
    final apiProducts = await apiSource.fetchProducts(skip: page, limit: limit);
    //save to cache
    await localSource.saveProducts(apiProducts);
    //return updated cached data
    return localSource.getCachedProducts();
  }

  @override
  List<Product> getCachedProducts() {
    return localSource.getCachedProducts();
  }
}

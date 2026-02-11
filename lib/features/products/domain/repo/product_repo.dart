import 'package:dartz/dartz.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';

abstract class ProductRepo {
  Future<Either<String, List<Product>>> fetchAllproducts(int page, int limit);
  Future<Either<String, List<Product>>> fetchProductsByCategory(String catName);
  Future<Either<String, List<Product>>> searchProducts(String query);
  List<Product> getCachedProducts();
}

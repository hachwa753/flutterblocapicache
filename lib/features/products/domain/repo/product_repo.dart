import 'package:flutterapiecommerce/features/products/domain/model/product.dart';

abstract class ProductRepo {
  Future<List<Product>> fetchAllproducts(int page, int limit);
  Future<List<Product>> fetchProductsByCategory(String catName);
  Future<List<Product>> searchProducts(String query);
  List<Product> getCachedProducts();
}

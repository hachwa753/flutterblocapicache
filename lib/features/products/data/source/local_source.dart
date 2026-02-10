import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:hive/hive.dart';

class LocalSource {
  Box<Product> productBox = Hive.box<Product>("productBox");

  // get all products
  List<Product> getCachedProducts() => productBox.values.toList();

  // insert or update products
  Future<void> saveProducts(List<Product> products) async {
    for (var product in products) {
      await productBox.put(product.id, product);
    }
  }

  // clear products
  Future<void> clearProducts() async {
    await productBox.clear();
  }
}

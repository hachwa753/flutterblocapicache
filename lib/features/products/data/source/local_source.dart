import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:hive/hive.dart';

class LocalSource {
  Box<Product> productBox = Hive.box<Product>("productBox");

  // get all products
  List<Product> getCachedProducts() => productBox.values.toList();

  // insert or update products
  Future<void> saveProducts(List<Product> products) async {
    // 1. Get all existing keys in Hive
    // final existingKeys = productBox.keys.cast<int>().toSet();

    // // 2. Get all IDs from API
    // final apiKeys = products.map((p) => p.id).toSet();

    // // 3. Delete products that are no longer in API
    // final keysToDelete = existingKeys.difference(apiKeys);
    // for (var key in keysToDelete) {
    //   await productBox.delete(key);
    // }
    for (var product in products) {
      await productBox.put(product.id, product);
    }
  }

  // clear products
  Future<void> clearProducts() async {
    await productBox.clear();
  }
}

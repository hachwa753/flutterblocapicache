import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CatLocalSource {
  final Box<Categories> categoryBox = Hive.box<Categories>('categoryBox');

  // get all cached products
  List<Categories> getCachedCategories() => categoryBox.values.toList();

  // insert or update categories
  Future<void> saveCategories(List<Categories> categories) async {
    // 1. Get all existing keys in Hive
    final existingKeys = categoryBox.keys.cast<String>().toSet();

    // 2. Get all slugs from API
    final apiKeys = categories.map((c) => c.slug).toSet();

    // 3. Delete categories that are no longer in API
    final keysToDelete = existingKeys.difference(apiKeys);
    for (var key in keysToDelete) {
      await categoryBox.delete(key);
    }
    categories.map((e) => categoryBox.put(e.slug, e)).toList();
  }

  Future<void> clearCatCache() async => await categoryBox.clear();
}

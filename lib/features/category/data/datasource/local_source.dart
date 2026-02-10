import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';
import 'package:hive/hive.dart';

class CatLocalSource {
  final Box<Categories> categoryBox = Hive.box<Categories>('categoryBox');

  // get all cached products
  List<Categories> getCachedCategories() => categoryBox.values.toList();

  // insert or update categories
  Future<void> saveCategories(List<Categories> categories) async {
    categories.map((e) => categoryBox.put(e.slug, e)).toList();
  }

  Future<void> clearCatCache() async => await categoryBox.clear();
}

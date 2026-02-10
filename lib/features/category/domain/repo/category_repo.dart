import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';

abstract class CategoryRepo {
  Future<List<Categories>> fetchAllCategories();
  List<Categories> cachedCaetgories();
}

import 'package:flutterapiecommerce/features/category/data/datasource/cate_data_source.dart';
import 'package:flutterapiecommerce/features/category/data/datasource/local_source.dart';
import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';
import 'package:flutterapiecommerce/features/category/domain/repo/category_repo.dart';

class CategoriesRepoImpl extends CategoryRepo {
  final CateDataSource cateDataSource;
  final CatLocalSource localSource;
  CategoriesRepoImpl(this.cateDataSource, this.localSource);
  @override
  Future<List<Categories>> fetchAllCategories() async {
    try {
      final cachedCategories = localSource.getCachedCategories();
      if (cachedCategories.isNotEmpty) {
        _fetchAndUpdate();
        return cachedCategories;
      }
      return await _fetchAndUpdate();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  List<Categories> cachedCaetgories() {
    return localSource.getCachedCategories();
  }

  Future<List<Categories>> _fetchAndUpdate() async {
    try {
      final apiCategories = await cateDataSource.fetchCategories();
      await localSource.saveCategories(apiCategories);

      return localSource.getCachedCategories();
    } catch (e) {
      throw Exception("error$e");
    }
  }
}

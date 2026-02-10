import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutterapiecommerce/core/network/dio_client.dart';
import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';

class CateDataSource {
  final dio = DioClient().client;

  Future<List<Categories>> fetchCategories() async {
    try {
      final response = await dio.get('/products/categories');
      if (response.statusCode == 200) {
        final List data = response.data;
        // print(response.data);
        return data.map((e) => Categories.fromMap(e)).toList();
      } else {
        throw Exception("Failed to fetch categories: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch categories: ${e.message}');
    }
  }
}

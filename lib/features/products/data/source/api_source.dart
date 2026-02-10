import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutterapiecommerce/core/network/dio_client.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';

class ApiSource {
  final Dio dio = DioClient().client;

  Future<List<Product>> fetchProducts({
    required int skip,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/products',
        queryParameters: {'limit': limit, "skip": skip},
      );
      if (response.statusCode == 200) {
        final List data = response.data['products'];
        //  print(response.data);
        return data.map((e) => Product.fromMap(e)).toList();
      } else {
        throw Exception("Failed to fetch users: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  Future<List<Product>> getProductsByCategory(String catName) async {
    // log("hello--bycategory");
    try {
      final response = await dio.get('/products/category/$catName');
      // log('bycategory -- ${response.data}');
      if (response.statusCode == 200) {
        final List data = response.data['products'];
        log(response.data.toString());
        return data.map((e) => Product.fromMap(e)).toList();
      } else {
        throw Exception("Failed to fetch categories: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch categories: ${e.message}');
    }
  }

  Future<List<Product>> getProductsByQuery(String query) async {
    // log("hello--bycategory");
    try {
      final response = await dio.get(
        '/products/search',
        queryParameters: {'q': query},
      );
      // log('bycategory -- ${response.data}');
      if (response.statusCode == 200) {
        final List data = response.data['products'];
        log(response.data.toString());
        return data.map((e) => Product.fromMap(e)).toList();
      } else {
        throw Exception("Failed to fetch products: ${response.statusCode}");
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }
}

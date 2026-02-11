import 'package:flutter/material.dart';
import 'package:flutterapiecommerce/core/routes/app_routes.dart';
import 'package:flutterapiecommerce/features/category/presentation/screens/category_page.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/all_products_page.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/detail_page.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/home_page.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/root_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.homePage,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return RootScreen(shell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.homePage,
                builder: (context, state) => HomePage(),
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) {
                      final product = state.extra;
                      if (product == null || product is! Product) {
                        return Scaffold(
                          body: Center(child: Text("Product not found")),
                        );
                      }
                      return DetailPage(product: product);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.categories,
                builder: (context, state) => CategoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.products,
                builder: (context, state) => AllProductsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

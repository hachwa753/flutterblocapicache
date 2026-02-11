import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/core/routes/app_routes.dart';
import 'package:flutterapiecommerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/blocs/bloc/product_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/product_cat_page.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/search_page.dart';
import 'package:flutterapiecommerce/features/products/presentation/widgets/my_cat_container.dart';
import 'package:flutterapiecommerce/features/products/presentation/widgets/my_grid_container.dart';
import 'package:flutterapiecommerce/features/products/presentation/widgets/title_row_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchAllProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: HugeIcon(icon: HugeIcons.strokeRoundedSearch01),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(FetchAllProducts());
          context.read<CategoryBloc>().add(FetchAllCategories());
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                TitleRowWidget(
                  title: "Categories",
                  seeAllTxt: "See all",
                  seeAllTap: () {
                    context.push(AppRoutes.categories);
                  },
                ),
                SizedBox(height: 10),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state.categoryStatus == CategoryStatus.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state.categoryStatus == CategoryStatus.loaded) {
                      return SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              (state.categories.length > 4
                                  ? 4
                                  : state.categories.length),
                          itemBuilder: (context, index) {
                            // if (index == 0) {
                            //   return MyCatContainer(catTitle: "All");
                            // }
                            final category = state.categories[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ProductCatPage(category: category),
                                  ),
                                );
                              },
                              child: MyCatContainer(catTitle: category.name),
                            );
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: 10),
                TitleRowWidget(
                  seeAllTap: () {
                    context.push(AppRoutes.products);
                  },
                  title: "Products",
                  seeAllTxt: "See all",
                ),
                SizedBox(height: 17),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state.productStatus == ProductStatus.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state.productStatus == ProductStatus.failure) {
                      return Center(child: Text(e.toString()));
                    }
                    if (state.productStatus == ProductStatus.loaded) {
                      if (state.product.isEmpty) {
                        return Center(child: Text("No products found"));
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 240,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 5,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            state.product.length > 6 ? 6 : state.product.length,
                        itemBuilder: (context, index) {
                          final product = state.product[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push(
                                    '/homepage/detail',
                                    extra: product,
                                  );
                                },
                                child: MyGridContainer(
                                  title: product.title,
                                  thumbnail: product.thumbnail,
                                  price:
                                      "\$${product.price.toStringAsFixed(2)}",
                                  rating: product.rating.toString(),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

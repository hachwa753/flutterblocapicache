import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/product_cat_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All categories")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state.categoryStatus == CategoryStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.categoryStatus == CategoryStatus.loaded) {
                  if (state.categories.isEmpty) {
                    return Center(child: Text("Empty categories"));
                  }
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
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
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Text((index + 1).toString()),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  category.name,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

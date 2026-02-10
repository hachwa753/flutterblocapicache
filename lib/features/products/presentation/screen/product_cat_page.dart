import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';
import 'package:flutterapiecommerce/features/products/presentation/blocs/bloc/product_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/detail_page.dart';
import 'package:flutterapiecommerce/features/products/presentation/widgets/my_grid_container.dart';

class ProductCatPage extends StatefulWidget {
  final Categories category;
  const ProductCatPage({super.key, required this.category});

  @override
  State<ProductCatPage> createState() => _ProductCatPageState();
}

class _ProductCatPageState extends State<ProductCatPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetProductsByCat(widget.category.slug));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name)),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.productByCatStatus == ProductStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.productByCatStatus == ProductStatus.loaded) {
                  if (state.productByCat.isEmpty) {
                    return Center(child: Text("Empty texts"));
                  }
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 230,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: state.productByCat.length,
                      itemBuilder: (context, index) {
                        final product = state.productByCat[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => DetailPage(product: product),
                              ),
                            );
                          },
                          child: MyGridContainer(
                            title: product.title,
                            thumbnail: product.thumbnail,
                            price: "\$${product.price}",
                            rating: product.rating.toString(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/blocs/bloc/product_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/detail_page.dart';
import 'package:flutterapiecommerce/features/products/presentation/widgets/my_grid_container.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductBloc>().add(LoadMoreProducts());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Products")),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.productStatus == ProductStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.productStatus == ProductStatus.loaded) {
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 210,
                  crossAxisSpacing: 10,
                ),
                itemCount: state.product.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.product.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final product = state.product[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(product: product),
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
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

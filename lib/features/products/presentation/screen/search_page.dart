import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/blocs/bloc/product_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/cubits/search_cubit.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/detail_page.dart';

import 'package:hugeicons/hugeicons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          onChanged: (value) {
            final isEmpty = value.trim().isEmpty;
            searchCubit.setSearching(!isEmpty);
            if (isEmpty) {
              context.read<ProductBloc>().add(ClearSearch());
            } else {
              context.read<ProductBloc>().add(GetProductsByQuery(value));
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            suffixIcon: BlocSelector<SearchCubit, bool, bool>(
              selector: (state) => state,
              builder: (context, isSearching) {
                if (!isSearching) {
                  return SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HugeIcon(
                    size: 5,
                    icon: HugeIcons.strokeRoundedSearch01,
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state.productByQueryStatus == ProductStatus.loading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state.productByQueryStatus == ProductStatus.loaded) {
                if (state.productByQuery.isEmpty) {
                  return Center(child: Text("no products fetched"));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount:
                        state.productByQuery.length > 10
                            ? 10
                            : state.productByQuery.length,
                    itemBuilder: (context, index) {
                      final product = state.productByQuery[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailPage(product: product),
                            ),
                          );
                        },
                        leading: Image.network(product.thumbnail),
                        title: Text(product.title),
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
    );
  }
}

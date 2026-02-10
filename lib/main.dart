import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/category/data/datasource/cate_data_source.dart';
import 'package:flutterapiecommerce/features/category/data/datasource/local_source.dart';
import 'package:flutterapiecommerce/features/category/data/repo/categories_repo_impl.dart';
import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';
import 'package:flutterapiecommerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:flutterapiecommerce/features/products/data/repo/product_repo_impl.dart';
import 'package:flutterapiecommerce/features/products/data/source/api_source.dart';
import 'package:flutterapiecommerce/features/products/data/source/local_source.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:flutterapiecommerce/features/products/domain/model/reviews.dart';
import 'package:flutterapiecommerce/features/products/presentation/blocs/bloc/product_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/cubits/carousel_cubit.dart';
import 'package:flutterapiecommerce/features/products/presentation/cubits/search_cubit.dart';
import 'package:flutterapiecommerce/features/products/presentation/screen/root_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ReviewsAdapter());
  Hive.registerAdapter(ProductAdapter());

  Hive.registerAdapter(CategoriesAdapter());
  await Hive.openBox<Product>('productBox');
  await Hive.openBox<Categories>('categoryBox');
  final apiSource = ApiSource();
  final localSource = LocalSource();
  final productRepo = ProductRepoImpl(apiSource, localSource);

  final catApiSource = CateDataSource();
  final catLocalSource = CatLocalSource();
  final categoryRepo = CategoriesRepoImpl(catApiSource, catLocalSource);
  runApp(MyApp(productRepoImpl: productRepo, categoriesRepoImpl: categoryRepo));
}

class MyApp extends StatelessWidget {
  final ProductRepoImpl productRepoImpl;
  final CategoriesRepoImpl categoriesRepoImpl;
  const MyApp({
    super.key,
    required this.productRepoImpl,
    required this.categoriesRepoImpl,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc(productRepoImpl)),
        BlocProvider(create: (context) => CarouselCubit()),
        BlocProvider(
          create:
              (context) =>
                  CategoryBloc(categoriesRepoImpl)..add(FetchAllCategories()),
        ),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: RootScreen()),
    );
  }
}

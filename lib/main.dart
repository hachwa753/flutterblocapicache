import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/core/di/injection.dart';
import 'package:flutterapiecommerce/core/routes/app_router.dart';
import 'package:flutterapiecommerce/features/category/domain/model/categories.dart';
import 'package:flutterapiecommerce/features/category/presentation/blocs/bloc/category_bloc.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:flutterapiecommerce/features/products/domain/model/reviews.dart';
import 'package:flutterapiecommerce/features/products/presentation/blocs/bloc/product_bloc.dart';
import 'package:flutterapiecommerce/features/products/presentation/cubits/carousel_cubit.dart';
import 'package:flutterapiecommerce/features/products/presentation/cubits/search_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ReviewsAdapter());
  Hive.registerAdapter(ProductAdapter());

  Hive.registerAdapter(CategoriesAdapter());
  await Hive.openBox<Product>('productBox');
  await Hive.openBox<Categories>('categoryBox');
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProductBloc>()..add(FetchAllProducts()),
        ),
        BlocProvider(create: (context) => CarouselCubit()),
        BlocProvider(
          create: (context) => getIt<CategoryBloc>()..add(FetchAllCategories()),
        ),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

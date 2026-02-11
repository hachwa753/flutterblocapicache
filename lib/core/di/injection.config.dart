// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutterapiecommerce/features/category/data/datasource/cate_data_source.dart'
    as _i144;
import 'package:flutterapiecommerce/features/category/data/datasource/local_source.dart'
    as _i983;
import 'package:flutterapiecommerce/features/category/data/repo/categories_repo_impl.dart'
    as _i394;
import 'package:flutterapiecommerce/features/category/domain/repo/category_repo.dart'
    as _i398;
import 'package:flutterapiecommerce/features/category/presentation/blocs/bloc/category_bloc.dart'
    as _i229;
import 'package:flutterapiecommerce/features/products/data/repo/product_repo_impl.dart'
    as _i729;
import 'package:flutterapiecommerce/features/products/data/source/api_source.dart'
    as _i784;
import 'package:flutterapiecommerce/features/products/data/source/local_source.dart'
    as _i826;
import 'package:flutterapiecommerce/features/products/domain/repo/product_repo.dart'
    as _i127;
import 'package:flutterapiecommerce/features/products/presentation/blocs/bloc/product_bloc.dart'
    as _i132;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i144.CateDataSource>(() => _i144.CateDataSource());
    gh.lazySingleton<_i983.CatLocalSource>(() => _i983.CatLocalSource());
    gh.lazySingleton<_i784.ApiSource>(() => _i784.ApiSource());
    gh.lazySingleton<_i826.LocalSource>(() => _i826.LocalSource());
    gh.lazySingleton<_i398.CategoryRepo>(() => _i394.CategoriesRepoImpl(
          gh<_i144.CateDataSource>(),
          gh<_i983.CatLocalSource>(),
        ));
    gh.lazySingleton<_i127.ProductRepo>(() => _i729.ProductRepoImpl(
          gh<_i784.ApiSource>(),
          gh<_i826.LocalSource>(),
        ));
    gh.factory<_i229.CategoryBloc>(
        () => _i229.CategoryBloc(gh<_i398.CategoryRepo>()));
    gh.factory<_i132.ProductBloc>(
        () => _i132.ProductBloc(gh<_i127.ProductRepo>()));
    return this;
  }
}

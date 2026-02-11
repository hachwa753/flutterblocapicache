import 'package:flutterapiecommerce/features/cart/data/datasource/cart_datasource.dart';
import 'package:flutterapiecommerce/features/cart/domain/model/cart.dart';
import 'package:flutterapiecommerce/features/cart/domain/repo/cart_repo.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';

class CartRepoImpl extends CartRepo {
  final CartDatasource datasource;
  CartRepoImpl(this.datasource);
  @override
  Future<List<Cart>> getAllCarts() async {
    return datasource.cart;
  }

  @override
  Future<void> addToCart(Product product) async {
    return datasource.addToCart(product);
  }
}

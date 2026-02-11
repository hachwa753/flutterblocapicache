import 'package:flutterapiecommerce/features/cart/domain/model/cart.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';

abstract class CartRepo {
  Future<List<Cart>> getAllCarts();
  Future<void> addToCart(Product product);
}

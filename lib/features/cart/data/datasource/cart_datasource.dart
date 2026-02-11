import 'package:flutterapiecommerce/features/cart/domain/model/cart.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';

class CartDatasource {
  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

  Future<void> addToCart(Product product) async {
    final newCart = Cart(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      qty: 1,
      product: product,
      isSelected: false,
    );
    _cart.add(newCart);
  }
}

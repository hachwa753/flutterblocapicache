// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

enum CartStatus { initial, loading, loaded, failure }

class CartState extends Equatable {
  final CartStatus cartStatus;
  final String? msz;
  final List<Cart> cart;
  const CartState({
    this.cartStatus = CartStatus.initial,
    this.cart = const [],
    this.msz,
  });

  @override
  List<Object?> get props => [cartStatus, cart, msz];

  CartState copyWith({CartStatus? cartStatus, String? msz, List<Cart>? cart}) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      msz: msz ?? this.msz,
      cart: cart ?? this.cart,
    );
  }
}

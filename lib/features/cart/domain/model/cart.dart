// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutterapiecommerce/features/products/domain/model/product.dart';

class Cart extends Equatable {
  final String id;
  final int qty;
  final Product product;
  final bool isSelected;

  const Cart({
    required this.id,
    required this.qty,
    required this.product,
    required this.isSelected,
  });

  @override
  List<Object?> get props => [id, qty, product, isSelected];

  Cart copyWith({String? id, int? qty, Product? product, bool? isSelected}) {
    return Cart(
      id: id ?? this.id,
      qty: qty ?? this.qty,
      product: product ?? this.product,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

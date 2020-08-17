import 'dart:convert';

import 'package:bioshopapp/models/cart.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final List<Product> products;
  final List<CartProduct> cartProducts;
  const AppState({
    @required this.products,
    @required this.cartProducts,
  });

  factory AppState.initial() {
    return AppState(products: [], cartProducts: []);
  }
}

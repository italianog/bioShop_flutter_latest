import 'dart:convert';

import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ShopItem shopItem;
  final List<Product> products;
  final List<Product> cartProducts;
  const AppState({
    @required this.shopItem,
    @required this.products,
    @required this.cartProducts,
  });

  factory AppState.initial() {
    return AppState(products: [], cartProducts: []);
  }
}

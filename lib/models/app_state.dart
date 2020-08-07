import 'dart:convert';

import 'package:bioshopapp/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ShopItem shopItem;

  const AppState({
    @required this.shopItem,
  });

//  dynamic toJson() => {
//        'shopItem': shopItem,
//      };

//  @override
//  String toString() {
//    return 'AppState: ${JsonEncoder.withIndent(' ').convert(this)}';
//  }
}

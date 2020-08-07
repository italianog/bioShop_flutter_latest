import 'package:redux/redux.dart';
import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/models/models.dart';

final shopItemReducer = TypedReducer<ShopItem, AddItem>(_addItemReducer);

ShopItem _addItemReducer(ShopItem state, AddItem action) {
  return action.shopItem;
}

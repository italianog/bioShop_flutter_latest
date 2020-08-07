import 'package:bioshopapp/models/models.dart';
import 'package:bioshopapp/reducers/shop_item_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    shopItem: shopItemReducer(state.shopItem, action),
  );
}

import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/models/cart.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/models.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    products: productsReducer(state.products, action),
    cartProducts: cartProducts(state.cartProducts, action),
  );
}

List<Product> productsReducer(List<Product> products, action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}

List<CartProduct> cartProducts(List<CartProduct> cartProducts, dynamic action) {
  if (action is ToggleCartProductAction) {
    return action.cartProducts;
  }
  return cartProducts;
}

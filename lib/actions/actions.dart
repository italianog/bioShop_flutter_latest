import 'package:bioshopapp/models/cart.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/models.dart';
import 'package:bioshopapp/pages/firebase_testing_fetchData.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

//PRODUCT ACTIONS!

ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  QuerySnapshot querySnapshot = await itemsRef.getDocuments();
  List<dynamic> products_snaps = querySnapshot.documents;
  List<Product> products = [];
  products_snaps.forEach((element) {
    Product prodotto = Product.fromDocument(element);
    products.add(prodotto);
  });
  store.dispatch(GetProductsAction(products));
};

class GetProductsAction {
  final List<Product> _products;
  int _productsCount;

  List<Product> get products => this._products;
  GetProductsAction(this._products);
}

//CartProduct Actions
ThunkAction<AppState> toggleCartProductAction(CartProduct cartProduct) {
  return (Store<AppState> store) {
    final List<CartProduct> cartProducts = store.state.cartProducts;
    final int index = cartProducts.indexWhere(
        (product) => product.prodotto.id == cartProduct.prodotto.id);
    bool isInCart = index > -1 == true;
    List<CartProduct> updatedCartProducts = List.from(cartProducts);
    if (isInCart) {
      updatedCartProducts.removeAt(index);
    } else {
      updatedCartProducts.add(cartProduct);
    }
    store.dispatch(ToggleCartProductAction(updatedCartProducts));
  };
}

class ToggleCartProductAction {
  final List<CartProduct> _cartProducts;

  List<CartProduct> get cartProducts => this._cartProducts;

  ToggleCartProductAction(this._cartProducts);
}

ThunkAction<AppState> incrementCartProductAction(CartProduct cartProduct) {
  return (Store<AppState> store) {
    final List<CartProduct> cartProducts = store.state.cartProducts;
    final int index = cartProducts.indexWhere(
        (product) => product.prodotto.id == cartProduct.prodotto.id);
    List<CartProduct> updatedCartProducts = List.from(cartProducts);
    updatedCartProducts[index].qta += 1;

    store.dispatch(IncrementCartProductAction(updatedCartProducts));
  };
}

class IncrementCartProductAction {
  final List<CartProduct> _cartProducts;

  List<CartProduct> get cartProducts => this._cartProducts;

  IncrementCartProductAction(this._cartProducts);
}

ThunkAction<AppState> decrementCartProductAction(CartProduct cartProduct) {
  return (Store<AppState> store) {
    final List<CartProduct> cartProducts = store.state.cartProducts;
    final int index = cartProducts.indexWhere(
        (product) => product.prodotto.id == cartProduct.prodotto.id);
    List<CartProduct> updatedCartProducts = List.from(cartProducts);
    if (updatedCartProducts[index].qta > 0) {
      updatedCartProducts[index].qta -= 1;
    }
    store.dispatch(DecrementCartProductAction(updatedCartProducts));
  };
}

class DecrementCartProductAction {
  final List<CartProduct> _cartProducts;

  List<CartProduct> get cartProducts => this._cartProducts;

  DecrementCartProductAction(this._cartProducts);
}

ThunkAction<AppState> removeCartProductAction(CartProduct cartProduct) {
  return (Store<AppState> store) {
    final List<CartProduct> cartProducts = store.state.cartProducts;
    final int index = cartProducts.indexWhere(
        (product) => product.prodotto.id == cartProduct.prodotto.id);
    CartProduct rimosso = cartProducts.removeAt(index);
    List<CartProduct> updatedCartProducts = List.from(cartProducts);
    store.dispatch(RemoveCartProductAction(updatedCartProducts));
  };
}

class RemoveCartProductAction {
  final List<CartProduct> _cartProducts;

  List<CartProduct> get cartProducts => this._cartProducts;

  RemoveCartProductAction(this._cartProducts);
}

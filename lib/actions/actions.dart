import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/models.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  QuerySnapshot querySnapshot = await itemsRef.getDocuments();
  List<dynamic> products = querySnapshot.documents;
  store.dispatch(GetProductsAction(products));
};

class GetProductsAction {
  final List<dynamic> _products;

  List<dynamic> get products => this._products;
  GetProductsAction(this._products);
}

class AddItem {
  final ShopItem shopItem;

  AddItem(this.shopItem);
}

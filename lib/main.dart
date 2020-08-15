import 'package:bioshopapp/pages/firebase_testing_fetchData.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:bioshopapp/pages/shop.dart';
import 'package:bioshopapp/widgets/SideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bioshopapp/models/models.dart';
import 'package:bioshopapp/reducers/app_reducer.dart';
import 'package:bioshopapp/actions/actions.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
      shopItem: ShopItem(),
    ),
    middleware: [
      LoggingMiddleware.printer(),
      thunkMiddleware,
    ],
  );

  print("InitialState: ${store.state}");

  runApp(StoreProvider(store: store, child: MyApp()));
  fetchData();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BioShop',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      routes: {
//        'shop': (BuildContext context) => Shop(onInit: () {
//              StoreProvider.of<AppState>(context).dispatch(getProductsAction);
//            }),
//      },
      home: Homepage(),
    );
  }
}

import 'package:bioshopapp/pages/homepage.dart';
import 'package:bioshopapp/widgets/SideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bioshopapp/models/models.dart';
import 'package:bioshopapp/reducers/app_reducer.dart';
import 'package:bioshopapp/actions/actions.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
      shopItem: ShopItem(
        nome: "Ciao",
        desc: "Desc",
      ),
    ),
    middleware: [new LoggingMiddleware.printer()],
  );

  print("InitialState: ${store.state}");

  runApp(StoreProvider(store: store, child: MyApp()));
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
      home: Homepage(),
    );
  }
}

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
    initialState: AppState.initial(),
    middleware: [
      LoggingMiddleware.printer(),
      thunkMiddleware,
    ],
  );

  runApp(MyApp(
    store: store,
  ));
  print("InitialState: ${store.state.cartProducts}");

  //fetchData();
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BioShop',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Homepage(),
      ),
    );
  }
}

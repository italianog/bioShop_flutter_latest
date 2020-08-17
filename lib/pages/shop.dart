import 'package:bioshopapp/pages/checkout_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bioshopapp/widgets/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bioshopapp/models/app_state.dart';

final List<Widget> lista_one = [
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1528825871115-3581a5387919?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=658&q=80",
          prezzo: 3.99,
          feedCount: 9,
          rating: 4,
          nome: "Banana",
          disp: 10,
          desc: "America,Centrale")),
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1579613832125-5d34a13ffe2a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
          prezzo: 2.99,
          feedCount: 3,
          rating: 5,
          nome: "Mela",
          disp: 10,
          desc: "Marlene")),
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1589533610925-1cffc309ebaa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
          prezzo: 4.99,
          feedCount: 5,
          rating: 4,
          nome: "Fragola",
          disp: 10,
          desc: "Sicilia")),
];

final List<Widget> lista_two = [
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1591538579798-ddcb99b7e16c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
          prezzo: 4.99,
          feedCount: 12,
          rating: 3,
          nome: "Melone Retato",
          disp: 10,
          desc: "Roma")),
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1572635148818-ef6fd45eb394?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
          prezzo: 2.99,
          feedCount: 50,
          rating: 5,
          nome: "Limone",
          disp: 10,
          desc: "Sicilia")),
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1531171596281-8b5d26917d8b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
          prezzo: 3.99,
          feedCount: 14,
          rating: 4,
          nome: "Pesca",
          disp: 10,
          desc: "Calabria")),
];

final List<Widget> lista_three = [
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/flagged/photo-1579410137922-543ed48d263e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
          prezzo: 5.99,
          feedCount: 22,
          rating: 4,
          nome: "Noce",
          disp: 10,
          desc: "Sicilia")),
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1550258987-190a2d41a8ba?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
          prezzo: 4.99,
          feedCount: 28,
          rating: 4,
          nome: "Ananas",
          disp: 10,
          desc: "Paraguay")),
  ItemCard_list(
      product: Product(
          photoUrl:
              "https://images.unsplash.com/photo-1590420409557-35c2469693a2?ixlib=rb-1.2.1&auto=format&fit=crop&w=975&q=80",
          prezzo: 8.99,
          feedCount: 11,
          rating: 4,
          nome: "Ciliegia",
          disp: 10,
          desc: "Napoli")),
];

class Shop extends StatefulWidget {
  final void Function() onInit;

  Shop({this.onInit});

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        height: 40.0,
        child: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(),
            ),
            hintText: "Cerca oggetto BioShop",
            hintStyle: TextStyle(fontSize: 14),
            filled: true,
            prefixIcon: Icon(
              Icons.search,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: clearSearch,
            ),
          ),
          onFieldSubmitted: handleSearch,
        ),
      ),
    );
  }

  void clearSearch() {
    searchController.clear();
  }

  handleSearch(String stringa) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: Container(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Visualizzati di recente",
                              style: TextStyle(fontFamily: "Poppins"),
                            ),
                          ),
                          ListExample(myList: lista_one),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Simili a quello che hai visto",
                              style: TextStyle(fontFamily: "Poppins"),
                            ),
                          ),
                          ListExample(myList: lista_two),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Ti potrebbe piacere",
                              style: TextStyle(fontFamily: "Poppins"),
                            ),
                          ),
                          ListExample(myList: lista_three),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListExample extends StatelessWidget {
  List<Widget> myList = [];
  ListExample({this.myList});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: myList,
      ),
    );
  }
}

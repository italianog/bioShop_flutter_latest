import 'package:bioshopapp/pages/checkout_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bioshopapp/widgets/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final List<Widget> lista_one = [
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1568&q=80",
  ),
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1579613832125-5d34a13ffe2a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
  ),
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1581375074612-d1fd0e661aeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1651&q=80",
  ),
];

final List<Widget> lista_two = [
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1580912534328-fbc00d6f7e9f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1647&q=80",
  ),
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1517260911058-0fcfd733702f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2013&q=80",
  ),
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1481349518771-20055b2a7b24?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2009&q=80",
  ),
];

final List<Widget> lista_three = [
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1518635017498-87f514b751ba?ixlib=rb-1.2.1&auto=format&fit=crop&w=1652&q=80",
  ),
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1544070078-a212eda27b49?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2089&q=80",
  ),
  ItemCard_list(
    imgUrl:
        "https://images.unsplash.com/photo-1490885578174-acda8905c2c6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1649&q=80",
  ),
];

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
        child: SafeArea(
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

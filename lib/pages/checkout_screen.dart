import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/models/app_state.dart';
import 'package:bioshopapp/models/cart.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/widgets/custom_button.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart';

class Checkout extends StatefulWidget {
  @override
  List<CartProduct> cart;

  Checkout({this.cart});

  _CheckoutState createState() => _CheckoutState();
}

double calcolaTotale(BuildContext context) {
  final store = StoreProvider.of<AppState>(context);
  double sum = 0.0;
  store.state.cartProducts.forEach((prodotto) {
    sum += prodotto.prodotto.prezzo * prodotto.qta;
  });
  return sum;
}

class _CheckoutState extends State<Checkout> {
  Widget _cartTab() {
    return Scaffold(
      body: Container(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: state.cartProducts.length > 0
                        ? ListView.builder(
                            itemCount: state.cartProducts.length,
                            itemBuilder: (context, i) => CartItem(
                              item: state.cartProducts[i],
                            ),
                          )
                        : Center(
                            child: Text("Il tuo carrello è attualmente vuoto"),
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "TOTALE : " +
                            calcolaTotale(context).toStringAsPrecision(3) +
                            " €",
                        style: TextStyle(fontSize: 18.0, fontFamily: "Poppins"),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _payment() {
    return Center(child: Text('Payment'));
  }

  Widget _details() {
    return Center(child: Text("Details"));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white70,
            bottom: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.lightBlue,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.credit_card,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.receipt,
                  ),
                ),
              ],
            ),
            title: Text(
              "Carrello",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _cartTab(),
              _payment(),
              _details(),
            ],
          )),
    );
  }
}

class CartItem extends StatelessWidget {
  CartProduct item;
  StoreProvider store;

  CartItem({this.item, this.store});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: GridTile(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      CachedNetworkImageProvider(item.prodotto.photoUrl),
                ),
                title: Container(
                    padding: EdgeInsets.only(top: 10, left: 10.0),
                    child: Text(item.prodotto.nome)),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    final store = StoreProvider.of<AppState>(context);
                    store.dispatch(removeCartProductAction(item));
                  },
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(item.prodotto.prezzo.toString() + " €"),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          onPressed: () {
                            final store = StoreProvider.of<AppState>(context);
                            store.dispatch(decrementCartProductAction(item));
                            print(store.state.cartProducts.first.prodotto.nome);
                            print(store.state.cartProducts.first.qta);
                          },
                        ),
                        Text(item.qta.toString()),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          onPressed: () {
                            final store = StoreProvider.of<AppState>(context);
                            store.dispatch(incrementCartProductAction(item));
                            print(store.state.cartProducts.first.prodotto.nome);
                            print(store.state.cartProducts.first.qta);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}

//class ItemCard extends StatefulWidget {
//  String text;
//  String imgUrl;
//  double prezzo;
//
//  ItemCard({this.text, this.imgUrl, this.prezzo});
//
//  @override
//  _ItemCardState createState() => _ItemCardState();
//}
//
//class _ItemCardState extends State<ItemCard> {
//  @override
//  int numero = 1;
//
//  Widget build(BuildContext context) {
//    return Card(
//      color: Color(0xffe0e9f3),
//      elevation: 5.0,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(15.0),
//      ),
//      child: Container(
//        padding: EdgeInsets.all(8.0),
//        child: Row(
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            CircleAvatar(
//              backgroundImage: CachedNetworkImageProvider(widget.imgUrl),
//              radius: 30,
//            ),
//            Column(
//              children: <Widget>[
//                Text(
//                  widget.text,
//                  style: TextStyle(fontFamily: "Poppins"),
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    ClipOval(
//                      child: Material(
//                        color: Colors.blueGrey.withOpacity(0.6), // button color
//                        child: InkWell(
//                          splashColor: Colors.lightBlue, // inkwell color
//                          child: SizedBox(
//                            width: 20,
//                            height: 20,
//                            child: Icon(
//                              FontAwesomeIcons.chevronLeft,
//                              color: Colors.white,
//                              size: 14,
//                            ),
//                          ),
//                          onTap: () {
//                            setState(() {
//                              if (numero > 0) {
//                                numero -= 1;
//                              }
//                            });
//                          },
//                        ),
//                      ),
//                    ),
//                    Container(
//                      padding:
//                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
//                      child: Text(
//                        numero.toString(),
//                      ),
//                    ),
//                    ClipOval(
//                      child: Material(
//                        color: Colors.blueGrey.withOpacity(0.6), // button color
//                        child: InkWell(
//                          splashColor: Colors.lightBlue, // inkwell color
//                          child: SizedBox(
//                            width: 20,
//                            height: 20,
//                            child: Icon(
//                              FontAwesomeIcons.chevronRight,
//                              color: Colors.white,
//                              size: 14.0,
//                            ),
//                          ),
//                          onTap: () {
//                            setState(() {
//                              numero += 1;
//                            });
//                          },
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
//                Container(
//                  child: Text(
//                    "€ " + widget.prezzo.toString(),
//                    style: TextStyle(
//                        fontWeight: FontWeight.bold, fontFamily: "Poppins"),
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

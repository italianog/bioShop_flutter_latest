import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/models/app_state.dart';
import 'package:bioshopapp/models/cart.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/order.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Miriam/Desktop/bioshop_vendi/bioshop_vendi/lib/widgets/custom_button.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart';

class Checkout extends StatefulWidget {
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

void createOrder(BuildContext context) {
  String id = DateTime.now().toString();
  final store = StoreProvider.of<AppState>(context);
  Order ordine = Order(
      orderId: "$id",
      prezzo: calcolaTotale(context),
      username: currentUser.username);

  ordersRef.document("$id").setData({
    'orderId': "$id",
    "username": "${ordine.username}",
    "prezzo": ordine.prezzo,
  });

  store.state.cartProducts.forEach((element) {
    ordersRef
        .document(id)
        .collection("carrello")
        .document("${element.prodotto.id}")
        .setData({
      //Solo campo qta e query per cercare oggetto tramite id!
      "desc": "${element.prodotto.desc}",
      "nome": "${element.prodotto.nome}",
      "prezzo": element.prodotto.prezzo,
      "qta": element.qta,
      "photoUrl": element.prodotto.photoUrl,
    });
  });
}

class _CheckoutState extends State<Checkout> {
  bool orderConfirmed = false;
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
                              index: i,
                            ),
                          )
                        : Center(
                            child: Text("Il tuo carrello è attualmente vuoto"),
                          ),
                  ),
                ),
//                state.cartProducts.length > 0
//                    ? Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Container(
//                            child: CustomButton(
//                                onTap: () {
//                                  _showMyDialog_clear(context);
//                                  final store =
//                                      StoreProvider.of<AppState>(context);
//                                  store.dispatch(removeAllCartProductAction());
//                                  print(store.state.cartProducts.length);
//                                },
//                                text: "Svuota Carrello",
//                                colore: Colors.redAccent),
//                          ),
//                        ],
//                      )
//                    : Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "TOTALE : " +
                            calcolaTotale(context).toStringAsFixed(2) +
                            " €",
                        style: TextStyle(fontSize: 18.0, fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                ),
                state.cartProducts.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: CustomButton(
                                onTap: () {
                                  _showMyDialog(context);
                                  final store =
                                      StoreProvider.of<AppState>(context);
                                  createOrder(context);
                                  store.dispatch(removeAllCartProductAction());
                                },
                                text: "Conferma Ordine",
                                colore: Colors.lightBlue),
                          ),
                        ],
                      )
                    : Text(""),
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
  int index;

  CartItem({this.item, this.store, this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: index == 0 ? EdgeInsets.only(top: 10) : EdgeInsets.all(0),
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

Future<void> _showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.blue)),
        title: Text("Grazie per l'ordine"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Riceverai a breve una mail di conferma'),
//              Text('Per migliorare la nostra App'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CONTINUA'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showMyDialog_clear(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
        title: Text("Ordine annullato"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Carrello Svuotato'),
//              Text('Per migliorare la nostra App'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CONTINUA'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

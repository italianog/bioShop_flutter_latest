import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  List<ItemCard> carrello = [
    ItemCard(
      imgUrl:
          "https://images.unsplash.com/photo-1557800636-894a64c1696f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1001&q=80",
      text: "Mandarini Siciliani",
      prezzo: 4.99,
    ),
    ItemCard(
        imgUrl:
            'https://images.unsplash.com/photo-1549007953-2f2dc0b24019?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=975&q=80',
        text: "Fragole Biologiche DOP",
        prezzo: 9.99),
    ItemCard(
      imgUrl:
          'https://images.unsplash.com/photo-1572635148818-ef6fd45eb394?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
      text: "Limoni Siciliani",
      prezzo: 3.99,
    ),
    ItemCard(
      imgUrl:
          'https://images.unsplash.com/photo-1577730618729-76ab611700b3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
      text: "Mandarini Bio",
      prezzo: 2.99,
    ),
  ];

  double calcolaTotale() {
    double totale = 0.0;
    for (var elemento in carrello) {
      totale += elemento.prezzo;
    }
    return totale;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: CachedNetworkImageProvider(
//                "https://images.unsplash.com/photo-1578264271517-a3e0f4f67312?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"),
//            fit: BoxFit.cover,
            //             ),
            ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Checkout",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black45,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: carrello,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Totale Ordine",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              color: Colors.black45),
                        ),
                        Text(
                          "€ " + calcolaTotale().toStringAsPrecision(4),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              color: Colors.black45),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomButton(
                      text: "Conferma Ordine",
                      colore: Colors.lightBlue,
                      icona: FontAwesomeIcons.checkCircle,
                      onTap: null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  String text;
  String imgUrl;
  double prezzo;

  ItemCard({this.text, this.imgUrl, this.prezzo});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  int numero = 1;

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(widget.imgUrl),
              radius: 30,
            ),
            Column(
              children: <Widget>[
                Text(
                  widget.text,
                  style: TextStyle(fontFamily: "Poppins"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blueGrey.withOpacity(0.6), // button color
                        child: InkWell(
                          splashColor: Colors.lightBlue, // inkwell color
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (numero > 0) {
                                numero -= 1;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                      child: Text(
                        numero.toString(),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        //elevation: 5.0,     NON FUNZIONA!
                        color: Colors.blueGrey.withOpacity(0.6), // button color
                        child: InkWell(
                          splashColor: Colors.lightBlue, // inkwell color
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              numero += 1;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Text(
                    "€ " + widget.prezzo.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

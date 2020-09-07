import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/pages/detail_page.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'file:///C:/Users/Miriam/Desktop/bioshop_vendi/bioshop_vendi/lib/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

List<Product> tmp = [];

bool findAlreadyExists(String id) {
  var snaps =
      usersRef.document(currentUser.id).collection('feedbacks').document(id);
  if (snaps.documentID != null) {
    return true;
  }
  return false;
}

class Ordine extends StatefulWidget {
  List<Product> prodotti;
  DocumentSnapshot ds;
  String orderId;

  Ordine({this.prodotti, this.ds, this.orderId});

  @override
  _OrdineState createState() => _OrdineState();
}

class _OrdineState extends State<Ordine> {
  bool showSubmit = false;
  bool showTextField = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: Text(
            "Dettaglio Ordine",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection("orders")
                .document(widget.orderId)
                .collection("carrello")
                .snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                default:
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        List oggetti = snapshot.data.documents.toList();
                        return Column(
                          children: [
                            Padding(
                              padding: index == 0
                                  ? EdgeInsets.only(
                                      top: 8.0, left: 16.0, right: 16.0)
                                  : const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      oggetti[index]['photoUrl']),
                                ),
                                title: Text(oggetti[index]['nome']),
                                subtitle: Text(
                                    oggetti[index]['prezzo'].toString() + " €"),
                                trailing: findAlreadyExists(
                                            oggetti[index]['id']) ==
                                        true
                                    ? SmoothStarRating(
                                        allowHalfRating: true,
                                        onRated: (v) {
                                          setState(() {
                                            showSubmit = true;
                                            showTextField = true;
                                          });
                                        },
                                        starCount: 5,
                                        size: 22.0,
                                        color: Colors.orange,
                                        borderColor: Colors.black12,
                                        spacing: 0.0,
                                      )
                                    : Text("Hai già recensito questo prodotto"),
                              ),
                            ),
                            showTextField
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText:
                                              "Inserisci un feedback per il prodotto",
                                          hintStyle: TextStyle(fontSize: 14)),
                                    ),
                                  )
                                : Text(""),
                            Divider(
                              color: Colors.black54,
                            ),
                            index == snapshot.data.documents.length - 1
                                ? showSubmit
                                    ? SizedBox(
                                        child: (CustomButton(
                                          onTap: () {
                                            _showMyDialog(context);
                                          },
                                          colore: Colors.blue,
                                          text: "Lascia Feedback",
                                        )),
                                      )
                                    : Text("")
                                : Text(""),
                          ],
                        );
                      });
              }
            }));
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
        title: Text('Grazie per il Feedback'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('La tua opinione è importante'),
              Text('Per migliorare il nostro negozio'),
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

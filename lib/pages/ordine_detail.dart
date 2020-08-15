import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Ordine extends StatefulWidget {
  @override
  _OrdineState createState() => _OrdineState();
}

class _OrdineState extends State<Ordine> {
  bool showSubmit = false;
  bool showTextField = false;

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
      body: Card(
        child: Column(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          "https://images.unsplash.com/photo-1550258987-190a2d41a8ba?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"),
                    ),
                    title: Text("Ananas"),
                    subtitle: Text("5.99€"),
                    trailing: SmoothStarRating(
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
                    ),
                  ),
                ),
                showTextField
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Inserisci un feedback per il prodotto",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      )
                    : Text(""),
                Divider(color: Colors.black54),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1268&q=80"),
                    ),
                    title: Text("Avocado"),
                    subtitle: Text("8.99€"),
                    trailing: SmoothStarRating(
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
                    ),
                  ),
                ),
                showTextField
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Inserisci un feedback per il prodotto",
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      )
                    : Text(""),
                Divider(color: Colors.black54),
              ],
            ),
            showSubmit
                ? (CupertinoButton(
                    onPressed: () {
                      _showMyDialog(context);
                    },
                    color: Colors.blue,
                    child: Text(
                      "Lascia Feedback",
                    ),
                  ))
                : Text(""),
          ],
        ),
      ),
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
        title: Text('Grazie per il Feedback'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('La tua opinione è importante'),
              Text('Per migliorare la nostra App'),
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

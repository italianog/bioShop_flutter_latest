import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homepage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class buildOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<QuerySnapshot> ordersFuture;
    Future<QuerySnapshot> orders = ordersRef.getDocuments();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xFF202328),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                "Il mio Profilo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFe9ecf1),
                  fontSize: 16.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(
                      currentUser.photoUrl,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                currentUser.username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFe9ecf1),
                  fontSize: 22.0,
                ),
              ),
            ),
//            Container(
//              alignment: Alignment.centerLeft,
//              padding: EdgeInsets.only(top: 4.0),
//              child: Text(
//                currentUser.displayName,
//                style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  color: Color(0xFFe9ecf1),
//                  fontSize: 16.0,
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 20,
//            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                "I miei ordini",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFe9ecf1),
                  fontSize: 16,
                ),
              ),
            ),
            Card(
              elevation: 1.2,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.euro_symbol,
                      color: Colors.blue,
                    ),
                    title: Text("Order n. "),
                    subtitle: Text("Eseguito in data 25/07/2020, pari a 200€"),
                    isThreeLine: true,
                    trailing: Icon(Icons.more_vert),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 10,
                    indent: 20,
                    endIndent: 0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.euro_symbol,
                      color: Colors.blue,
                    ),
                    title: Text("Order n. "),
                    subtitle: Text("Eseguito in data 25/07/2020, pari a 200€"),
                    isThreeLine: true,
                    trailing: Icon(Icons.more_vert),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 10,
                    indent: 20,
                    endIndent: 0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.euro_symbol,
                      color: Colors.blue,
                    ),
                    title: Text("Order n. "),
                    subtitle: Text("Eseguito in data 25/07/2020, pari a 200€"),
                    isThreeLine: true,
                    trailing: Icon(Icons.more_vert),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

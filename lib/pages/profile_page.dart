import 'package:bioshopapp/pages/preferiti.dart';
import 'package:bioshopapp/pages/vendite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:bioshopapp/pages/vendi.dart';

import 'ordini_details.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Center(
                child: Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage:
                    CachedNetworkImageProvider("https://tinyurl.com/y2dm5al7"),
                backgroundColor: Colors.transparent,
              ),
            ),
            Center(
              child: Text(
                "Giovanni",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.deepOrange,
                        child: Container(
                          child: Text(
                            "5",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        padding: EdgeInsets.all(8.0),
                        shape: CircleBorder(),
                      ),
                      Container(
                        child: Text(
                          "Acquistati",
                          style: TextStyle(color: Colors.black45),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.blueAccent,
                        child: Container(
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        padding: EdgeInsets.all(8.0),
                        shape: CircleBorder(),
                      ),
                      Container(
                        child: Text(
                          "Venduti",
                          style: TextStyle(color: Colors.black45),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.indigoAccent,
                        child: Container(
                          child: Text(
                            "12",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        padding: EdgeInsets.all(8.0),
                        shape: CircleBorder(),
                      ),
                      Container(
                        child: Text(
                          "Feedback",
                          style: TextStyle(color: Colors.black45),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              alignment: Alignment.topLeft,
              child: Text(
                "Più acquistati",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(2),
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 2.0),
                        child: Text(
                          "Frutta Tropicale",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      elevation: 2.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(2),
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 2.0),
                        child: Text(
                          "Km Zero",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      elevation: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              alignment: Alignment.topLeft,
              child: Text(
                "Più venduti",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(2),
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 2.0),
                        child: Text(
                          "Agrumi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      elevation: 2.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(2),
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 2.0),
                        child: Text(
                          "Frutta Bio",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      elevation: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Divider(color: Colors.black54),
//                ListTile(
//                  onTap: () {
//                    print("Suca");
//                  },
//                  title: Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                    child: Text("I miei ordini"),
//                  ),
//                  trailing: IconButton(
//                    icon: Icon(Icons.arrow_right),
//                  ),
//                ),
//                Divider(color: Colors.black54),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ordini(),
                      ),
                    );
                  },
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("I miei acquisti"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_right),
                  ),
                ),
                Divider(color: Colors.black54),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Vendite(),
                      ),
                    );
                  },
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Le mie vendite"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_right),
                  ),
                ),
                Divider(color: Colors.black54),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Preferiti(),
                      ),
                    );
                  },
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("I miei Preferiti"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_right),
                  ),
                ),
                Divider(color: Colors.black54),
              ],
            )
          ],
        ),
      ),
    );
  }
}

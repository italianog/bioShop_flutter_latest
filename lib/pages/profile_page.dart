import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: CachedNetworkImageProvider(
                    "https://png2.kisspng.com/sh/c525d4fca63a88646c57f15e1d55c045/L0KzQYm3VsI3N6Z8i5H0aYP2gLBuTfF3aaVmip9Ac3X1PbT2jgB2fJZ3Rdtsb372PcT2hwR4aaNqRdZudnXvf8Hskr02amQ3T9VsOXPmQYbtV745P2M8SqkDMEG4Q4G3U8U1OGI9S6g3cH7q/kisspng-avatar-user-computer-icons-software-developer-5b327cc9cc15f7.872727801530035401836.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
            Text(
              "Giovanni",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
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
                "Interessi",
                style: TextStyle(
                  fontSize: 22,
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
                      child: Text("Sono una card di prova"),
                      elevation: 2.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(2),
                    child: Card(
                      child: Text("Sono una card di prova"),
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
                  fontSize: 22,
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
                      child: Text("Sono una card di prova"),
                      elevation: 2.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(2),
                    child: Card(
                      child: Text("Sono una card di prova"),
                      elevation: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

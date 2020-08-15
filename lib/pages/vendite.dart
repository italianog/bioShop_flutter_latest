import 'package:bioshopapp/pages/vendi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'inserzione.dart';

class Vendite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          centerTitle: true,
          title: Text(
            "Vendite",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: Column(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Inserzione(),
                      ),
                    );
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Ordine #1549856467"),
                      Text(
                        "54.99 €",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text("10/08/2020"),
                  ),
                  trailing: Icon(Icons.more_vert),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 40.0),
              child: CupertinoButton(
                child: Text("Vendi nuovo prodotto"),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Vendi()));
                },
              ),
            ),
          ],
        ));
  }
}

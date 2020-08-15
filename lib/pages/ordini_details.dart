import 'package:flutter/material.dart';

import 'ordine_detail.dart';

class Ordini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ordini",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white70,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ordine(),
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
                Divider(color: Colors.black54),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Ordine #1549856469"),
                      Text(
                        "89.99 €",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text("12/08/2020"),
                  ),
                  trailing: Icon(Icons.more_vert),
                ),
                Divider(color: Colors.black54),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

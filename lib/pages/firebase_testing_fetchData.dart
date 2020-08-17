import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/cart.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SafeArea(
            child: Center(
              child: Text("TESTING PAGE"),
//              itemCount: products.length,
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 2,
//              ),
//              itemBuilder: (context, i) =>
//                  Center(child: Text(products[i]['nome'])),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/models/item.dart';

List<dynamic> products = [];

void fetchData() async {
  var output = await itemsRef.getDocuments();
  for (var i = 0; i < output.documents.length; i++) {
    var x = output.documents[i];
    products.add(x.data);
  }
  print("Number of Items: ${products.length}");

  products.forEach((element) {
    print(element);
  });
}

//{TODO}
//Product getProductbyId(String id) {
//  var x;
//  var docRef = itemsRef.document(id);
//  docRef.get().then((value) {
//    x = value;
//    Product pr = Product.fromDocument(value);
//    return pr;
//  });
//}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SafeArea(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, i) =>
                  Center(child: Text(products[i]['nome'])),
            ),
          ),
        ),
      ],
    );
  }
}

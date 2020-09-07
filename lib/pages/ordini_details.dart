import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ordine_detail.dart';

// List<Product> caricaProdotti(DocumentSnapshot ds) {
//   List<Product> prodotti = [];
//   print(ds.reference.path);
//   ds.reference.collection("carrello").snapshots().forEach((element) {
//     element.documents.forEach((element) {
//       Product pr = Product(
//           nome: element.data["nome"],
//           photoUrl: element.data["photoUrl"],
//           prezzo: element.data["prezzo"]);
//       print("Prodotto");
//       print(pr);
//       prodotti.add(pr);
//     });
//   });
//
//   print("PRODOTTI");
//   print(prodotti.length);
//   return prodotti;
// }

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
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: ordersRef.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Non sono presenti ordini");
              } else {
                List<DocumentSnapshot> items;
                items = snapshot.data.documents;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ordine(
                                  orderId: ds.data["orderId"],
                                ),
                              ),
                            );
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${ds.data['orderId']}"),
                              Text(
                                ds.data['prezzo'].toString().substring(0, 4) +
                                    " €",
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Text("${ds.data['orderId']}"),
                          ),
                          trailing: Icon(Icons.more_vert),
                        ),
                        Divider(color: Colors.black54),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

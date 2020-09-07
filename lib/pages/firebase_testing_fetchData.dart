import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:bioshopapp/pages/single_shop.dart';
import 'package:bioshopapp/widgets/item_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/models/cart.dart';

addFavoriteShop(String shopName, String photoUrl) {
  usersRef
      .document("104304702015831572882")
      .collection('favorites')
      .document('104304702015831572882')
      .collection("shops")
      .document(shopName)
      .setData({
    "nome": shopName,
    "photoUrl": photoUrl,
    "shop": "shop",
  });
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Negozi",
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white54,
      ),
      body: StreamBuilder(
        stream: shopsRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Non ci sono negozi al momento");
          } else {
            List<DocumentSnapshot> shops;
            shops = snapshot.data.documents;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return Column(
                  children: <Widget>[
                    Container(
                      padding: index == 0
                          ? EdgeInsets.only(top: 15)
                          : EdgeInsets.all(0),
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (ds.data['isLiked'] == true) {
                            ds.reference.updateData({"isLiked": false});
                          } else {
                            ds.reference.updateData({"isLiked": true});
                            addFavoriteShop(
                                ds.data['shopName'], ds.data['photoUrl']);
                          }
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleShop()));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(ds.data['photoUrl']),
                          ),
                          trailing: IconButton(
                              icon: ds.data['isLiked'] == false
                                  ? Icon(Icons.favorite_border)
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )),
                          title: Text(ds.data['shopName']),
                          subtitle: Text(ds.data['desc']),
                        ),
                      ),
                    ),
                    Divider(color: Colors.black54),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

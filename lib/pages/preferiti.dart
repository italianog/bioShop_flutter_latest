import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'homepage.dart';

class _favItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersRef
          .document(currentUser.id)
          .collection("favorites")
          .document('104304702015831572882')
          .collection('items')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
          return Center(child: Text("Non ci sono ancora prodotti preferiti"));
        } else {
          List<DocumentSnapshot> favorites;
          favorites = snapshot.data.documents;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              return Column(
                children: <Widget>[
                  Container(
                    padding: index == 0
                        ? EdgeInsets.only(top: 10)
                        : EdgeInsets.all(0),
                    child: ListTile(
                      title: Text(ds.data['nome']),
                      subtitle: Text(ds.data['shop']),
                      leading: CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(ds.data['photoUrl']),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          ds.reference.delete();
                        },
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

class _favShops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersRef
          .document(currentUser.id)
          .collection("favorites")
          .document('104304702015831572882')
          .collection('shops')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
          return Center(child: Text("Non ci sono ancora negozi preferiti"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          List<DocumentSnapshot> favorites;
          favorites = snapshot.data.documents;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              return Column(
                children: <Widget>[
                  Container(
                    padding: index == 0
                        ? EdgeInsets.only(top: 10)
                        : EdgeInsets.all(0),
                    child: ListTile(
                      title: Text(ds.data['nome']),
                      subtitle: Text(ds.data['shop']),
                      leading: CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(ds.data['photoUrl']),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          ds.reference.delete();
                        },
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

class Preferiti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Preferiti",
            style: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.white54,
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.lightBlue,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.shop),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.lemon),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[_favShops(), _favItems()],
        ),
      ),
    );
  }
}

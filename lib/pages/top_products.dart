import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:bioshopapp/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopProducts extends StatefulWidget {
  @override
  _TopProductsState createState() => _TopProductsState();
}

class _TopProductsState extends State<TopProducts> {
  Future<QuerySnapshot> topRatedFuture;

  handleRating() {
    Future<QuerySnapshot> items =
        itemsRef.where('rating', isGreaterThanOrEqualTo: 3).getDocuments();

    setState(() {
      topRatedFuture = items;
    });
  }

  buildTopRated() {
    handleRating();
    return FutureBuilder(
        future: topRatedFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<TopRated> ratingResults = [];
          snapshot.data.documents.forEach((doc) {
            Item item = Item.fromDocument(doc);
            TopRated ratingResult = TopRated(item);
            ratingResults.add(ratingResult);
          });
          return ListView(
            children: ratingResults,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    const dark = Color(0xff121212);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
        title: Text(
          "I più venduti",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
//        decoration: BoxDecoration(
//            image: DecorationImage(
//          image: AssetImage(
//            "assets/images/bgtwo.jpg",
//          ),
//          fit: BoxFit.cover,
//        )),
        child: buildTopRated(),
      ),
    );
  }
}

class TopRated extends StatelessWidget {
  final Item item;

  TopRated(this.item);

  List<Widget> countStars(int rating) {
    final StarIcon = Icon(
      Icons.star,
      size: 15,
      color: Colors.yellow,
    );
    List<Widget> lista = [];
    for (var i = 0; i < rating; i++) {
      lista.add(StarIcon);
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => print('tapped'),
        child: GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 1,
          childAspectRatio: 1,
          crossAxisSpacing: 2.0,
          children: <Widget>[
            GridTile(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(item.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
//                    Container(
//                      color: Colors.white.withOpacity(0.4),
//                      child: Text(
//                        item.title,
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          color: Colors.black,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                    ),
//                    Container(
//                      color: Colors.white.withOpacity(0.4),
//                      child: Text(
//                        item.desc,
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          color: Colors.black,
//                        ),
//                      ),
//                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: countStars(item.rating),
                      ),
                    ),
//                    Container(
//                      color: Colors.white.withOpacity(0.4),
//                      child: Text(
//                        item.prezzo.toString(),
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          color: Colors.black,
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

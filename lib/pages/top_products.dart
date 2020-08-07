import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/pages/detail_page.dart';
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
        return Column(
          children: <Widget>[
            Stories(),
            Expanded(
              child: ListView(
                children: ratingResults,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "I più venduti",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
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
    return Column(
      children: [
        Container(
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(),
                ),
              ),
            },
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
                        image: CachedNetworkImageProvider(item.photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
//                              IconButton(
//                                icon: Icon(
//                                  Icons.favorite_border,
//                                ),
//                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: countStars(item.rating),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Consigliati dagli utenti",
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.redAccent.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1557800636-894a64c1696f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1001&q=80'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.redAccent.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1549007953-2f2dc0b24019?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=975&q=80'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.redAccent.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1572635148818-ef6fd45eb394?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.redAccent.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://images.unsplash.com/photo-1577730618729-76ab611700b3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.redAccent.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1581375074612-d1fd0e661aeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80'),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

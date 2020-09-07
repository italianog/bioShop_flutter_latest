import 'package:bioshopapp/models/item.dart';
import 'package:bioshopapp/pages/detail_page.dart';
import 'package:bioshopapp/pages/firebase_testing_fetchData.dart';
import 'package:bioshopapp/pages/homepage.dart';
import 'package:bioshopapp/widgets/progress.dart';
import 'package:bioshopapp/widgets/storia.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/widgets/custom_button.dart';

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
          Product item = Product.fromDocument(doc);
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
  final Product item;

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
                  builder: (context) => Detail(item: item),
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
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1557800636-894a64c1696f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=802&q=80",
                    prezzo: 2.99,
                    rating: 5,
                    nome: "Mandarino",
                    disp: 10,
                    desc: "DOP Sicilia"),
              ),
              Story(
                prodotto: Product(
                  photoUrl:
                      "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1268&q=80",
                  prezzo: 8.99,
                  rating: 5,
                  nome: "Avocado",
                  disp: 10,
                  desc: "America Centrale",
                ),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1528825871115-3581a5387919?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=658&q=80",
                    prezzo: 3.99,
                    rating: 4,
                    nome: "Banana",
                    disp: 10,
                    desc: "America,Centrale"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1579613832125-5d34a13ffe2a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
                    prezzo: 2.99,
                    rating: 5,
                    nome: "Mela",
                    disp: 10,
                    desc: "Marlene"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1589533610925-1cffc309ebaa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
                    prezzo: 4.99,
                    rating: 4,
                    nome: "Fragola",
                    disp: 10,
                    desc: "Sicilia"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1591538579798-ddcb99b7e16c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
                    prezzo: 4.99,
                    rating: 3,
                    nome: "Melone_Retato",
                    disp: 10,
                    desc: "Roma"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1572635148818-ef6fd45eb394?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
                    prezzo: 2.99,
                    rating: 5,
                    nome: "Limone",
                    disp: 10,
                    desc: "Sicilia"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1531171596281-8b5d26917d8b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80",
                    prezzo: 3.99,
                    rating: 4,
                    nome: "Pesca",
                    disp: 10,
                    desc: "Calabria"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/flagged/photo-1579410137922-543ed48d263e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80",
                    prezzo: 5.99,
                    rating: 4,
                    nome: "Noce",
                    disp: 10,
                    desc: "Sicilia"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1571337547740-a56ef4b5aa05?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
                    prezzo: 3.99,
                    rating: 2,
                    nome: "Fico",
                    disp: 10,
                    desc: "Sicilia"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1550258987-190a2d41a8ba?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                    prezzo: 4.99,
                    rating: 4,
                    nome: "Ananas",
                    disp: 10,
                    desc: "Paraguay"),
              ),
              Story(
                prodotto: Product(
                    photoUrl:
                        "https://images.unsplash.com/photo-1590420409557-35c2469693a2?ixlib=rb-1.2.1&auto=format&fit=crop&w=975&q=80",
                    prezzo: 8.99,
                    rating: 4,
                    nome: "Ciliegia",
                    disp: 10,
                    desc: "Napoli"),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Story extends StatelessWidget {
  Product prodotto;

  Story({this.prodotto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 42,
        backgroundColor: Colors.redAccent.withOpacity(0.5),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Storia(
                          product: this.prodotto,
                        )));
          },
          child: CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(prodotto.photoUrl),
          ),
        ),
      ),
    );
  }
}

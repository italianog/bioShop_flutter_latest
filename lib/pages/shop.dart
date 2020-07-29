import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    const dark = Color(0xff121212);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
        title: Text(
          "Negozio",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      'https://i.ibb.co/DWGWjYt/itemone.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.white.withOpacity(0.4),
                    child: Text(
                      'Cuffie On Ear Philips Ultra Powa9000',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.4),
                    child: Text(
                      "Ultra powa over 9 thousands",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star),
                        Icon(Icons.star),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.4),
                    child: Text(
                      "50.00€",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

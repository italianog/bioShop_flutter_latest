import 'dart:async';

import 'package:bioshopapp/pages/single_shop.dart';
import 'package:bioshopapp/widgets/custom_button.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/models/item.dart';
import 'package:swipedetector/swipedetector.dart';

class Storia extends StatefulWidget {
  final Product product;

  Storia({this.product});

  @override
  _StoriaState createState() => _StoriaState();
}

class _StoriaState extends State<Storia> {
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    // Timer timer = Timer(Duration(seconds: 10), () {
    //   Navigator.pop(context);
    // });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Stack(
            children: [
              SwipeDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image:
                          CachedNetworkImageProvider(widget.product.photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onSwipeUp: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 25.0,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        // timer.cancel();
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: CustomButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleShop()));
                      },
                      text: "Visita il negozio",
                      colore: Colors.deepOrangeAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

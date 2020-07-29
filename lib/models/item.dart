import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Item {
  final String title;
  final String desc;
  final double prezzo;
  final int rating;
  final String imgUrl;
  final int feedbacks;

  Item(
      {this.title,
      this.desc,
      this.prezzo,
      this.rating,
      this.imgUrl,
      this.feedbacks});

  factory Item.fromDocument(DocumentSnapshot doc) {
    return Item(
      title: doc['title'],
      desc: doc['desc'],
      prezzo: doc['prezzo'],
      rating: doc['rating'],
      imgUrl: doc['imgUrl'],
      feedbacks: doc['feedbacks'],
    );
  }
}

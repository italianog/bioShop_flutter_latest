import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String nome;
  final String desc;
  final double prezzo;
  final int rating;
  final String photoUrl;
  final int disp;
  final int feedCount;

  Product({
    this.id,
    this.nome,
    this.desc,
    this.prezzo,
    this.rating,
    this.photoUrl,
    this.disp,
    this.feedCount,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.documentID,
      nome: doc['nome'],
      desc: doc['desc'],
      prezzo: doc['prezzo'],
      rating: doc['rating'],
      photoUrl: doc['photoUrl'],
      disp: doc['disp'],
      feedCount: doc['feedCount'],
    );
  }

  List<Widget> countStars(Product product, Color colore) {
    // ignore: non_constant_identifier_names
    final StarIcon = Icon(
      Icons.star,
      size: 15,
      color: colore,
    );
    List<Widget> lista = [];
    for (var i = 0; i < product.rating; i++) {
      lista.add(StarIcon);
    }
    return lista;
  }
}

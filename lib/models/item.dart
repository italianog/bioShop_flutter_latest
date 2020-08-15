import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String nome;
  final String desc;
  final double prezzo;
  final int rating;
  final String photoUrl;
  final int disp;
  final int feedCount;

  Product({
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
      nome: doc['nome'],
      desc: doc['desc'],
      prezzo: doc['prezzo'],
      rating: doc['rating'],
      photoUrl: doc['photoUrl'],
      disp: doc['disp'],
      feedCount: doc['feedCount'],
    );
  }

//  Product getProductbyId(String id) {
//    var docRef = itemsRef.document(id);
//    docRef.get().then((doc) => Product.fromDocument(doc));
//  }

  List<Widget> countStars(Product product, Color colore) {
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

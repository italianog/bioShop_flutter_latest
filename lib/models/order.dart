import 'package:bioshopapp/models/cart.dart';
import 'package:bioshopapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
//  final List<CartProduct> carrello;
  final String orderId;
  final double prezzo;
  final String username;
//  final User utente;
//  final DateTime date;

  Order({this.orderId, this.prezzo, this.username});

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order(
      orderId: doc.documentID,
      prezzo: doc['prezzo'],
//      date: doc['date'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order {
  final String order_id;
  final num totale;

  Order({this.order_id, this.totale, s});

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order(
      order_id: doc['order_id'],
      totale: doc['totale'],
    );
  }
}

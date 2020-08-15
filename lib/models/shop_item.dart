import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class ShopItem {
  final String nome;
  final String desc;
  final String id;
  final String photoUrl;
  final int disp;
  final int feedbacks;

  ShopItem copyWith({int disp}) {
    return ShopItem(
      disp: disp ?? this.disp,
    );
  }

  ShopItem(
      {this.nome,
      this.desc,
      this.id,
      this.photoUrl,
      this.disp,
      this.feedbacks});
}

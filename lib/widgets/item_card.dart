import 'package:bioshopapp/models/item.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bioshopapp/pages/detail_page.dart';
import 'package:bioshopapp/pages/homepage.dart';

class ItemCard_list extends StatefulWidget {
  final Product product;

  ItemCard_list({@required this.product});

  @override
  _ItemCard_listState createState() => _ItemCard_listState();
}

addFavorite(Product product) {
  usersRef
      .document("104304702015831572882")
      .collection('favorites')
      .document('104304702015831572882')
      .collection("items")
      .document(product.nome)
      .setData({
    "nome": product.nome,
    "photoUrl": product.photoUrl,
    "shop": "shop",
  });
}

class _ItemCard_listState extends State<ItemCard_list> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          widget.product.isLiked = !widget.product.isLiked;
        });
        addFavorite(widget.product);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(item: widget.product),
          ),
        );
      },
      child: Container(
        height: 180,
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(widget.product.photoUrl),
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
                  IconButton(
                    icon: Icon(
                      widget.product.isLiked == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.product.isLiked == true
                          ? Colors.redAccent.withOpacity(0.8)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.product.countStars(
                    this.widget.product, Colors.yellowAccent.withOpacity(0.8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

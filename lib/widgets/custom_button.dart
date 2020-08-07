import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function onTap;
  Color colore;
  String text;
  IconData icona;

  CustomButton({this.colore, this.text, this.onTap, this.icona});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: colore,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                icona,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

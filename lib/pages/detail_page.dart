import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<int> quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int _indexDropdown = 0;

  List<DropdownMenuItem<int>> getDropDownMenuCurrencyItems() {
    List<DropdownMenuItem<int>> items = new List();
    for (int qta in quantity) {
      items.add(
          new DropdownMenuItem(value: qta, child: new Text(qta.toString())));
    }
    return items;
  }

  void changeItem(selected) {
    setState(() {
      _indexDropdown = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Melone Retato",
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
        ),
        backgroundColor: Colors.white54,
      ),
      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.centerLeft,
//            end: Alignment.centerRight,
//            colors: [Colors.lightBlue, Colors.indigo],
//          ),
//        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
            child: ListView(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Melone Retato",
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                                SizedBox(width: 5.0),
                                Text("(25)"),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  "https://images.unsplash.com/photo-1571575173700-afb9492e6a50?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=976&q=80"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Prezzo:",
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                          Text(
                            "€ 3,99 / kg",
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                      DropdownButton(
                        hint: Text("Selezionare la quantità: "),
                        items: getDropDownMenuCurrencyItems(),
                        onChanged: (value) {
                          setState(() {
                            _indexDropdown = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          text: "Aggiungi al Carrello",
                          icona: FontAwesomeIcons.cartPlus,
                          colore: Colors.orangeAccent,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RelatedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.transparent,
        elevation: 3.0,
        child: Container(
          height: 160,
          width: 180,
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1543153694-4a27d3bfeca6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Cow Lane",
                  style: TextStyle(
                      color: Colors.black45,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

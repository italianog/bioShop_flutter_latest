import 'package:bioshopapp/models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bioshopapp/models/model_feedback.dart';

List<int> quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

final feedRef = Firestore.instance.collection('feedbacks');

class Detail extends StatefulWidget {
  Product item;

  Detail({this.item});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int _indexDropdown = 0;
  bool showFeedback = false;
  List<myFeedback> feedbacks = [];

  @override
  void initState() {
    super.initState();
    getFeedback();
  }

  void getFeedback() async {
    QuerySnapshot querySnapshot = await feedRef.getDocuments();
    var list = querySnapshot.documents;
    print(list[0].data);
    print(list[1].data);
    for (var i = 0; i < list.length; i++) {
      myFeedback feedback = myFeedback.fromDocument(list[i]);
      feedbacks.add(feedback);
    }
  }

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
          widget.item.nome,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            widget.item.nome,
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                ...widget.item.countStars(
                                    widget.item, Colors.orangeAccent),
                                SizedBox(width: 5.0),
                                Text("(" +
                                    widget.item.feedCount.toString() +
                                    ")"),
                              ],
                            ),
                          )
                        ],
                      ),
//                      Center(
//                        child: Text(
//                          widget.item.desc,
//                          style: TextStyle(color: Colors.black45),
//                        ),
//                      ),
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
                                  widget.item.photoUrl),
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
                            "€ " + widget.item.prezzo.toString(),
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                      Center(
                        child: DropdownButton(
                          hint: Text("Selezionare la quantità: "),
                          items: getDropDownMenuCurrencyItems(),
                          onChanged: (value) {
                            setState(() {
                              _indexDropdown = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomButton(
                            text: "Aggiungi al Carrello",
                            colore: Colors.orangeAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                showFeedback == false
                    ? CustomButton(
                        text: "Mostra Feedbacks",
                        colore: Colors.blue,
                        onTap: () {
                          setState(() {
                            showFeedback = true;
                          });
                        },
                      )
                    : ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Divider(color: Colors.grey),
                          Feedback_w(feedbacks[0]),
                          Divider(color: Colors.grey),
                          Feedback_w(feedbacks[1]),
                          Divider(color: Colors.grey),
                          Feedback_w(feedbacks[2]),
                        ],
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

class Feedback_w extends StatelessWidget {
  myFeedback feedback;

  Feedback_w(this.feedback);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(feedback.photoUrl),
          ),
          title: Text(feedback.feedback),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(feedback.username),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: 15.0,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: 15.0,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: 15.0,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: 15.0,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                    size: 15.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

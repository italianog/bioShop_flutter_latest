import 'package:bioshopapp/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bioshopapp/widgets/customForm_vendita.dart';
// import 'package:flutter_svg/flutter_svg.dart';

final tagsRef = Firestore.instance.collection('tags');

class Vendi extends StatefulWidget {
  @override
  _VendiState createState() => _VendiState();
}

class _VendiState extends State<Vendi> {
  List<DocumentSnapshot> tags;
  List<String> tagsStrings = [];
  int _currentIndex = 0;

  getTags() async {
    QuerySnapshot querySnapshot = await tagsRef.getDocuments();
    tags = querySnapshot.documents;
    for (var i = 0; i < tags.length; i++) {
      tagsStrings.add(tags[i]['tag']);
    }
    print(tagsStrings);
  }

  List<DropdownMenuItem<String>> getDropDownMenuCurrencyItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String tagString in tagsStrings) {
      items.add(
          new DropdownMenuItem(value: tagString, child: new Text(tagString)));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    getTags();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: Text(
            "Coming Soon",
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: true,
        ),
        body: Text("Rilascio nella versione 2.0"),
//        body: Column(
//          children: [
//            Center(
//              child: DropdownButton(
//                items: getDropDownMenuCurrencyItems(),
//                hint: Text("Selezionare la categoria"),
//                onChanged: (value) {
//                  setState(() {
//                    _currentIndex = value;
//                  });
//                },
//              ),
//            ),
//          ],
//        ),
      ),
    );
  }
}

class TagCard extends StatelessWidget {
  String text;

  TagCard({this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(text),
    );
  }
}

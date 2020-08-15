import 'package:cloud_firestore/cloud_firestore.dart';

class myFeedback {
  String feedback;
  String photoUrl;
  String username;
  int rating;

  myFeedback({this.feedback, this.photoUrl, this.username, this.rating});

  factory myFeedback.fromDocument(DocumentSnapshot doc) {
    return myFeedback(
      feedback: doc['feedback'],
      photoUrl: doc['photoUrl'],
      username: doc['username'],
      rating: doc['rating'],
    );
  }
}

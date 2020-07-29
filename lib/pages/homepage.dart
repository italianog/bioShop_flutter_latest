import 'package:bioshopapp/models/user.dart';
import 'package:bioshopapp/widgets/SideBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bioshopapp/pages/create_account.dart';
import 'package:bioshopapp/pages/search.dart';
import 'package:bioshopapp/pages/shop.dart';
import 'package:bioshopapp/pages/profile.dart';
import 'package:bioshopapp/pages/top_products.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final DateTime timestamp = DateTime.now();
final usersRef = Firestore.instance.collection('users');
final itemsRef = Firestore.instance.collection('items');
final ordersRef = Firestore.instance.collection('orders');

User currentUser;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

login() {
  googleSignIn.signIn();
}

logout() {
  googleSignIn.signOut();
}

class _HomepageState extends State<Homepage> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  Image bg;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    bg = Image.asset('assets/images/bg.jpg');
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignin(account);
    }, onError: (err) {
      print("error siginin in $err");
    });

    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignin(account);
    }).catchError((err) {
      print("Error signin in $err");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(bg.image, context);
  }

  handleSignin(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    // 1) check if user exists in users collection in database (according to their id)
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    if (!doc.exists) {
      // 2) if the user doesn't exist, then we want to take them to the create account page
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      // 3) get username from create account, use it to make new user document in users collection
      usersRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });

      doc = await usersRef.document(user.id).get();
    }

    currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          // Timeline(),
//          RaisedButton(
//            child: Text('Logout'),
//            onPressed: logout,
//          ),
          TopProducts(),
          Shop(),
          Search(),
          Profile(),
          buildUnAuthScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Colors.indigo,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.star_border)),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart)),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 35.0,
              ),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.code)),
          ]),
    );
//      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topRight,
//            end: Alignment.bottomLeft,
//            colors: [
//              Colors.blueAccent,
//              Colors.teal[600],
//            ],
//          ),
//        ),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Center(
//              child: RaisedButton(
//                color: Colors.deepOrange,
//                onPressed: logout,
//                child: Text(
//                  "Logout",
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontFamily: "Poppins",
//                    fontSize: 20,
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
  }

  Scaffold buildUnAuthScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //drawer: NavDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'bioShop',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 50.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: login,
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Login con Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: null,
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.fastfood,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Login con bioShop Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "Non hai ancora un account?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () => {print("Registrati pressed")},
                    child: Text(
                      "Registrati",
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () => {
                        print('first pressed'),
                      },
                      icon: FaIcon(FontAwesomeIcons.behance),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () => {
                        print('second pressed'),
                      },
                      icon: FaIcon(FontAwesomeIcons.facebook),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () => {
                        print('third pressed'),
                      },
                      icon: FaIcon(FontAwesomeIcons.instagram),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () => {
                        print('fourth pressed'),
                      },
                      icon: FaIcon(FontAwesomeIcons.twitch),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

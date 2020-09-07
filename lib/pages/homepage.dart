import 'package:bioshopapp/models/user.dart';
import 'package:bioshopapp/pages/profile_page.dart';
import 'package:bioshopapp/widgets/SideBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bioshopapp/pages/create_account.dart';
import 'package:bioshopapp/pages/search.dart';
import 'package:bioshopapp/pages/shop.dart';
import 'package:bioshopapp/pages/profile.dart';
import 'package:bioshopapp/pages/top_products.dart';
import 'package:bioshopapp/pages/checkout_screen.dart';
import 'package:bioshopapp/pages/signup_page.dart';
import 'firebase_testing_fetchData.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bioshopapp/models/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:bioshopapp/actions/actions.dart';
import 'package:bioshopapp/widgets/custom_button.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final DateTime timestamp = DateTime.now();
final usersRef = Firestore.instance.collection('users');
final itemsRef = Firestore.instance.collection('items');
final ordersRef = Firestore.instance.collection('orders');
final shopsRef = Firestore.instance.collection('shops');

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

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
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
      content: Text("Bentornato ${currentUser.username}"),
      backgroundColor: Colors.lightBlue.withOpacity(0.8),
      duration: Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
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
    } else {
      currentUser = User.fromDocument(doc);
      _showSuccessSnack();
      print(currentUser.username);
    }
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
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.lightBlue,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.star_border,
            size: 25,
          )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
          ),
//            BottomNavigationBarItem(
//              icon: Icon(
//                Icons.search,
//                size: 30.0,
//              ),
//            ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 25,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.list, size: 25),
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidCircle,
                  size: 25,
                  color: Colors.lightBlue,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    "0",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      key: _scaffoldKey,
      body: Container(
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return PageView(
              children: <Widget>[
//          RaisedButton(
//            child: Text('Logout'),
//            onPressed: logout,
//          ),
                TopProducts(),
                Shop(
                  onInit: () {
                    StoreProvider.of<AppState>(context)
                        .dispatch(getProductsAction);
                  },
                ),
//          Search(),
                ProfilePage(),
                Test(),
                Checkout(cart: state.cartProducts),
              ],
              controller: pageController,
              onPageChanged: onPageChanged,
              physics: NeverScrollableScrollPhysics(),
            );
          },
        ),
      ),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1557800634-7bf3c7305596?ixlib=rb-1.2.1&auto=format&fit=crop&w=1001&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
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
                CustomButton(
                  text: "Login con Google",
                  colore: Colors.blueAccent,
                  onTap: login,
                  icona: Icons.exit_to_app,
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
              height: 200,
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
              height: 30,
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

class MySnackBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text("Bentornato $currentUser"),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:flutter_auth/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
 final String phone = 'tel:+919429082510';

callPhone() async {
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }
int _custAdspent = 0;
int _custReach = 0;
int _custOrders = 0;
int _custClicks = 0;
int _custImp = 0;
bool loadingFlag;
int _pickedColor;

class _ProfilePageState extends State<ProfilePage> {
  Future addIntToSF(int tempColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('_ThemeColor', tempColor);
  }

  @override
  void initState() {
    super.initState();
    loadingFlag = false;

    print("profile page");
  }

  Future getUserData1() async {
    setState(() {
      loadingFlag = true;

      firestoreInstance
          .collection("customerDetails")
          .document(userId)
          .get()
          .then((value) => {
                _custAdspent = value.data['custAdspent'],
                _custReach = value.data['custReach'],
                _custOrders = value.data['custOrders'],
                _custClicks = value.data['custClicks'],
                _custImp = value.data['custImp'],
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3.0,
                              blurRadius: 5.0)
                        ],
                        color: Colors.white),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 15.0),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    userimageUrl,
                                  ),
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Hi, " + username,
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  useremail,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              getUserData1().whenComplete(() => {
                                    Timer(Duration(seconds: 1), () {
                                      setState(() {
                                        loadingFlag = false;
                                        custOrders = _custOrders;
                                        custImp = _custImp;
                                        custReach = _custReach;
                                        custAdspent = _custAdspent;
                                        custClicks = _custClicks;
                                      });
                                    })
                                  });
                            },
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3.0,
                                        blurRadius: 5.0)
                                  ],
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: (loadingFlag)
                                            ? CircularProgressIndicator()
                                            : CircleAvatar(
                                                child: Image.asset(
                                                    "assets/refresh.png"),
                                                radius: 15,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Text(
                                        "Refresh the data",
                                        style: TextStyle(
                                            fontFamily: "Varela",
                                            fontSize: 20,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Divider(
                        color: Colors.grey,
                      )),
                      Text(
                        "Overview",
                        style: TextStyle(
                            fontFamily: "Varela",
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                      Flexible(
                          child: Divider(
                        color: Colors.grey,
                      )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 20, top: 15, right: 5),
                          child: ConstrainedBox(
                            constraints: new BoxConstraints(
                                minHeight: size.height * 0.17),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3.0,
                                        blurRadius: 5.0)
                                  ],
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/order.png",
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            custOrders.toString(),
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 30,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Orders",
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20, top: 15, left: 5),
                          child: ConstrainedBox(
                            constraints: new BoxConstraints(
                                minHeight: size.height * 0.17),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3.0,
                                        blurRadius: 5.0)
                                  ],
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Image.asset(
                                        "assets/click.png",
                                        width: 40,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            custClicks.toString(),
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 30,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Clicks",
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3.0,
                                      blurRadius: 5.0)
                                ],
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        child: Image.asset("assets/imp.png"),
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          custImp.toString(),
                                          style: TextStyle(
                                              fontFamily: "Varela",
                                              fontSize: 30,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Impressions",
                                          style: TextStyle(
                                              fontFamily: "Varela",
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3.0,
                                      blurRadius: 5.0)
                                ],
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        child: Image.asset("assets/reach.png"),
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          custReach.toString(),
                                          style: TextStyle(
                                              fontFamily: "Varela",
                                              fontSize: 30,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Total Reach",
                                          style: TextStyle(
                                              fontFamily: "Varela",
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3.0,
                                      blurRadius: 5.0)
                                ],
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        child: Image.asset("assets/money.png"),
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          custAdspent.toString() + "/-",
                                          style: TextStyle(
                                              fontFamily: "Varela",
                                              fontSize: 30,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Ads spent",
                                          style: TextStyle(
                                              fontFamily: "Varela",
                                              fontSize: 15,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                      )),
                      Text(
                        "Extra",
                        style: TextStyle(
                            fontFamily: "Varela",
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                      )),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20, top: 15),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3.0,
                                      blurRadius: 5.0)
                                ],
                                color: Colors.white),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Change Theme Color",
                                        style: TextStyle(
                                            fontFamily: "Varela",
                                            fontSize: 15,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      height: 55,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _pickedColor = 0XFF3559FF;
                                                  addIntToSF(0XFF3559FF)
                                                      .whenComplete(() => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                              return MyApp();
                                                            }),
                                                                    ModalRoute
                                                                        .withName(
                                                                            '/'))
                                                          });
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 18.0,
                                                backgroundColor: Colors.blue,
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor:
                                                      Color(0XFF3559FF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _pickedColor = 0xFFF06292;
                                                  addIntToSF(0xFFF06292)
                                                      .whenComplete(() => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                              return MyApp();
                                                            }),
                                                                    ModalRoute
                                                                        .withName(
                                                                            '/'))
                                                          });
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 18.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor:
                                                      Colors.pink[200],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _pickedColor = 0XFF64B5F6;
                                                  addIntToSF(0XFF64B5F6)
                                                      .whenComplete(() => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                              return MyApp();
                                                            }),
                                                                    ModalRoute
                                                                        .withName(
                                                                            '/'))
                                                          });
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 18.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor:
                                                      Colors.blue[300],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _pickedColor = 0XFF9575CD;
                                                  addIntToSF(0XFF9575CD)
                                                      .whenComplete(() => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                              return MyApp();
                                                            }),
                                                                    ModalRoute
                                                                        .withName(
                                                                            '/'))
                                                          });
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 18.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor:
                                                      Colors.deepPurple[300],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _pickedColor = 0XFFFFB74D;
                                                  addIntToSF(0XFFFFB74D)
                                                      .whenComplete(() => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                              return MyApp();
                                                            }),
                                                                    ModalRoute
                                                                        .withName(
                                                                            '/'))
                                                          });
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 18.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor:
                                                      Colors.orange[300],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _pickedColor = 0XFFE57373;
                                                  addIntToSF(0XFFE57373)
                                                      .whenComplete(() => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                              return MyApp();
                                                            }),
                                                                    ModalRoute
                                                                        .withName(
                                                                            '/'))
                                                          });
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 18.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor:
                                                      Colors.red[300],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _pickedColor = 0XFF9E9E9E;
                                                  addIntToSF(0XFF9E9E9E)
                                                      .whenComplete(() => {
                                                            Navigator.of(
                                                                    context)
                                                                .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                              return MyApp();
                                                            }),
                                                                    ModalRoute
                                                                        .withName(
                                                                            '/'))
                                                          });
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 18.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15.0,
                                                  backgroundColor: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            print("Help Button Called");
                           // helpcall();
                           callPhone();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3.0,
                                        blurRadius: 5.0)
                                  ],
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          child:
                                              Image.asset("assets/help.png"),
                                          radius: 20,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Help Center",
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "24 x 7 call support",
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            signOut().whenComplete(() {
                              print("Logging Out");
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                return MyApp();
                              }), ModalRoute.withName('/'));
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3.0,
                                        blurRadius: 5.0)
                                  ],
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          child:
                                              Image.asset("assets/logout.png"),
                                          radius: 20,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Logout",
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Stop My Growth",
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // RaisedButton(

                  //     setState(() {
                  //      // _pickedColor = 0XFF81C784;
                  //       print("called");
                  //       addIntToSF(0XFF81C784);
                  //     });
                  //   },
                  //   color: Colors.white,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       'Sign out',
                  //       style: TextStyle(fontSize: 25, color: kPrimaryColor),
                  //     ),
                  //   ),
                  //   elevation: 5,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(40)),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

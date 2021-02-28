import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:flutter_auth/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;

  OrderDetailsPage({Key key, @required this.orderId}) : super(key: key);
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState(orderId);
}

int custAdspent1 = 0;
int custAdBudget1 = 0;

int custReach1 = 0;
int custImp1 = 0;

int custDailyBudget1 = 0;
int custDays1 = 0;

int custClicks1 = 0;
double custCpc1 = 0.0;
String orderStatus1;
bool orderFlag;

bool loadingFlag;
int pickedColor;

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String orderId;
  _OrderDetailsPageState(this.orderId);
  Future addIntToSF(int tempColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('_ThemeColor', tempColor);
  }

  @override
  void initState() {
    orderStatus1 = "none";

    super.initState();
    loadingFlag = false;
    orderFlag = false;

    getUserData1().whenComplete(() => {
          Timer(Duration(seconds: 1), () {
            setState(() {
              loadingFlag = false;
            });
          })
        });

    print("oderDetails page");
  }

  Future getUserData1() async {
    setState(() {
      loadingFlag = true;

      firestoreInstance
          .collection("orderDetails")
          .document(orderId)
          .get()
          .then((value) => {
                custAdspent1 = value.data['adSpent'],
                custAdBudget1 = value.data['adBudget'],
                custImp1 = value.data['imp'],
                custCpc1 = value.data['cpc'],
                custClicks1 = value.data['Clicks'],
                custDays1 = value.data['noOfDays'],
                custDailyBudget1 = value.data['dailyBudget'],
                orderStatus1 = value.data['orderStatus'],
                if (orderStatus1 == "canceled") {orderFlag = true}
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                              EdgeInsets.only(bottom: 10, top: 15, right: 5),
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
                                            "assets/cpc.png",
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
                                            custCpc1.toString(),
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 30,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "CPC",
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
                          margin: EdgeInsets.only(bottom: 10, top: 15, left: 5),
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
                                            custClicks1.toString(),
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
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20, right: 5),
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
                                    // Flexible(
                                    //   flex: 1,
                                    //   child: Column(
                                    //     children: <Widget>[
                                    //       Image.asset(
                                    //         "assets/order.png",
                                    //         width: 40,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            custDays1.toString(),
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 30,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Days",
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
                          margin: EdgeInsets.only(bottom: 20, left: 5),
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
                                        "assets/daily.png",
                                        width: 40,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            custDailyBudget1.toString(),
                                            style: TextStyle(
                                                fontFamily: "Varela",
                                                fontSize: 30,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Daily Budget",
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
                                          custImp1.toString(),
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
                                          custReach1.toString(),
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
                                        child: Image.asset("assets/budget.png"),
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
                                          custAdBudget1.toString() + "/-",
                                          style: TextStyle(
                                              fontFamily: "Varela",
                                              fontSize: 30,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Ads Budget",
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
                                          custAdspent1.toString() + "/-",
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
                 (!orderFlag)
                      ? Row(
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
                  ): Text(""),

                  (!orderFlag)
                      ? Row(
                          children: <Widget>[
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  deleteOrder(orderId).whenComplete(() {
                                    print("Deleting Order");
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: 20,
                                    top: 20,
                                  ),
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                child: Image.asset(
                                                    "assets/logout.png"),
                                                radius: 20,
                                                backgroundColor:
                                                    Colors.transparent,
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
                                                  "Cancel Order",
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
                        )
                      : Text("")
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

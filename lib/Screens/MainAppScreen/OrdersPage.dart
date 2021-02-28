import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'orderDetailsPage.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Widget _buildList(BuildContext context, DocumentSnapshot document, index) {
    var status = document["orderStatus"];
    Color tempColor;
    if (status == "pending") {
      tempColor = Colors.orangeAccent;
    } else if (status == "done") {
      tempColor = Colors.green;
    } else if (status == "ongoing") {
      tempColor = kPrimaryColor;
    } else if (status == "canceled") {
      tempColor = Colors.redAccent;
    } else {
      tempColor = Colors.purple;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OrderDetailsPage(orderId: document.documentID,),
    ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: tempColor,
                        child: Text((index + 1).toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      document['Clicks'].toString(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    Text(
                                      "Clicks",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.grey[300],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      document['adBudget'].toString(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    Text(
                                      "Budget",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.grey[300],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      document['adSpent'].toString(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    Text(
                                      "Spent",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: Text("All Your Orders",
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 15.0,
                    color: Color(0xFF545D68))),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      radius: 7,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Completed",
                                        style: TextStyle(
                                            fontFamily: 'Varela',
                                            fontSize: 12.0,
                                            color: Colors.grey)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30.0,
                                  width: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: kPrimaryColor,
                                      radius: 7,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Ongoing",
                                        style: TextStyle(
                                            fontFamily: 'Varela',
                                            fontSize: 12.0,
                                            color: Colors.grey)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30.0,
                                  width: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.orangeAccent,
                                      radius: 7,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Pending",
                                        style: TextStyle(
                                            fontFamily: 'Varela',
                                            fontSize: 12.0,
                                            color: Colors.grey)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30.0,
                                  width: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.redAccent,
                                      radius: 7,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Canceled",
                                        style: TextStyle(
                                            fontFamily: 'Varela',
                                            fontSize: 12.0,
                                            color: Colors.grey)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 20, bottom: 20, right: 8.0),
                    child: Text(
                      "Tap for more Order Details.",
                      style: TextStyle(
                          fontFamily: "Varela", color: Colors.grey[500]),
                    ),
                  ),
                  Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('orderDetails')
                          .where("customerId", isEqualTo: userId)
                          .snapshots(),

                      //print an integer every 2secs, 10 times
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        print(userId);
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.data.documents.length < 1) {
                          return Center(
                              child: Text(
                            "You don't have any orders",
                            style: TextStyle(
                                fontFamily: "Varela",
                                fontSize: 15.0,
                                color: Colors.grey),
                          ));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return _buildList(context,
                                  snapshot.data.documents[index], index);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/MainAppScreen/ProfilePage.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:flutter_auth/Screens/Welcome/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/services/AddUser.dart';

import 'package:flutter_auth/Screens/MainAppScreen/NavigationBody.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:math';

final firestoreInstance = Firestore.instance;
bool btnState = false;

class SelectLoc extends StatefulWidget {
  @override
  _SelectLocState createState() => _SelectLocState();
}

class _SelectLocState extends State<SelectLoc> {
  String city;
  bool isLoading = true;
  List<String> cities = [];
  Future getCities() async {
    firestoreInstance
        .collection(userBusiness)
        .document("cities")
        .get()
        .then((value) => {
              // custAdspent = value.data['custAdspent'],
              setState(() {
                cities = List.from(value.data['cities']);
                isLoading = false;
              }),
              print(cities)
            });
  }

  @override
  void initState() {
    super.initState();
    getCities().whenComplete(() => {print("done laoding")});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Image(image: AssetImage("assets/images/logo.png"), height: 55.0),
              SizedBox(height: size.height * 0.10),
              SvgPicture.asset(
                "assets/icons/map.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.10),
              Row(
                children: <Widget>[],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    height: size.height * 0.09,
                    width: size.width * 0.7,
                    child: Center(
                      child: (isLoading)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                CircularProgressIndicator(),
                                Text("Loading Cities..")
                              ],
                            )
                          : DropdownButton(
                              hint: Text("Select shop location"),
                              value: city,
                              items: cities.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  btnState = true;
                                  city = value;
                                });
                              },
                            ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),
              MaterialButton(
                  onPressed: () {
                    if (btnState) {
                      userLocation = city;
                      addNewUser().whenComplete(() => {
                            Timer(
                                Duration(seconds: 1),
                                () => {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => NavBody()))
                                    })
                          });
                    } else {}
                    // print(city);
                  },
                  child: Container(
                    height: size.height * 0.07,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: (btnState)?kPrimaryColor:kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Varela", color: (btnState)?Colors.white:Colors.black54),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

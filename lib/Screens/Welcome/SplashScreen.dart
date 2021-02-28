import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/MainAppScreen/NavigationBody.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/services/AddUser.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_auth/Screens/Demo/MainBody.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future addIntToSF(int tempColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('_ThemeColor', tempColor);
  }

  double _outerR = 80.0;
  double _innerR = 200.0;
  var animationCount = 0;
  void animationFun() {
    if (animationCount < 10000) {
      setState(() {
        final random = Random();
        if (animationCount % 2 == 0) {
          _innerR = _innerR + 20.0;
          // _outerR = _outerR + 30.0;
        } else {
          _innerR = _innerR - 20.0;
          // _outerR = _outerR - 30.0;
        }
      });
      animationCount++;
      Timer(Duration(milliseconds: 400), () => animationFun());
    } else {
      print("Animation completed!!");
      print(_innerR);
      setState(() {
        _outerR = 80.0;
        _innerR = 200.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getIntValuesSF() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return int
      int intValue = prefs.getInt('_ThemeColor') ?? 0XFF3559FF;
      setState(() {
        kPrimaryColor = Color(intValue);
      });
    }

    getIntValuesSF();
    //animationFun();
    initUser().whenComplete(() => {
          getCurrentUser().then((user) {
            if (user == null) {
              addIntToSF(0XFF3559FF);
              Timer(
                  Duration(seconds: 3),
                  () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    WelcomeScreen()))
                      });
            } else {
              isNewUser().whenComplete(() => {
                    if (newcustomer)
                      {
                        Timer(
                            Duration(seconds: 1),
                            () => {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyHomePage()))
                                })
                      }
                    else
                      {
                        Timer(
                            Duration(seconds: 1),
                            () => {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              NavBody()))
                                })
                      }
                  });
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          color: Color(0XFF3559FF),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Center(
                  child: AnimatedContainer(
                      duration: Duration(seconds: 3),
                      curve: Curves.fastOutSlowIn,
                      child: Image.asset(
                        'assets/images/logo_min.png',
                        width: size.width * 0.65,
                      )),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Fetching Data..",
                    style: TextStyle(fontSize: 15.0, color: Colors.white70),
                  ))
            ],
          )),
    );
  }
}

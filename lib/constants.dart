import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

 Color kPrimaryColor = Color(0xFF3559ff);
 Color kPrimaryLightColor = Color(0xFFecebff);
int _pickedColor = 0xFF3559ff;

 

class SetTheme extends StatefulWidget {
  @override
  _SetThemeState createState() => _SetThemeState();
}

class _SetThemeState extends State<SetTheme> {
  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('_ThemeColor') ?? 0XFF3559FF;
    setState(() {
      _pickedColor = intValue;
      kPrimaryColor = Color(_pickedColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      
    );
  }
}

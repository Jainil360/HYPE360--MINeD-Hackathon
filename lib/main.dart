import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:flutter_auth/Screens/Welcome/SplashScreen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Demo/selectLocation.dart';
import 'package:flutter_auth/Screens/Welcome/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', debugShowCheckedModeBanner: false, home: SplashPage());
  }
}

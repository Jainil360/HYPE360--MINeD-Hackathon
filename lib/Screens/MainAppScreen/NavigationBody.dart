import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_auth/Screens/Demo/Reach.dart';
import 'package:flutter_auth/Screens/MainAppScreen/OrdersPage.dart';
import 'package:flutter_auth/Screens/MainAppScreen/ProfilePage.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/services/sign_in.dart';


class NavBody extends StatefulWidget {
  NavBody({Key key}) : super(key: key);

  @override
  _NavBodyState createState() => _NavBodyState();
}

class _NavBodyState extends State<NavBody> {
  

  @override
  void initState() { 
    super.initState();
    // initUser();
  }
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  static List<Widget> _widgetOptions = <Widget>[
     OrdersPage(),
     ReachPage(),
     ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // appBar: AppBar(
      //   title: Center(child: Text("Hand 2 Hand ",style: TextStyle(fontFamily: 'HeadFont'),)),
      // ),

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        height: 55,
        backgroundColor: Colors.white,
        items: <Widget>[
          Image.asset('assets/images/graph.png',fit: BoxFit.cover,width: 25,),
          Image.asset('assets/images/rocket.png',fit: BoxFit.cover,width: 35,),
          Image.asset('assets/images/user.png',fit: BoxFit.cover,width: 28,),
          
        ],
        onTap: _onItemTapped,
        color: kPrimaryColor,
        buttonBackgroundColor: kPrimaryColor,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}

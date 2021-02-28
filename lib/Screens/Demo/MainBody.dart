import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:flutter_auth/services/sign_in.dart';

import 'SelectBusiness.dart';
import 'Reach.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kPrimaryColor),
            onPressed: () {},
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            SizedBox(height: 15.0),
            Text('Select \nYour Business...',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 32.0,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 15.0),
            CookiePage()
          ],
        ),
      ),
    );
  }
}

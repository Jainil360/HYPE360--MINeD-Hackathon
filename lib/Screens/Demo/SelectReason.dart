import 'package:flutter/material.dart';
import 'Reach.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/MainAppScreen/NavigationBody.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:flutter_auth/services/AddUser.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';

class ReasonPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return  GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        primary: false,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.7,
        children: <Widget>[
          _buildCard(
              'Cookie mint',
              'New Customers',
              'assets/images/newcustomer.gif',
              'newcustomer',
              true,
              context),
          _buildCard('Cookie cream', 'Brand Awareness',
              'assets/images/brand.gif', 'brandawareness', false, context),
          _buildCard('Cookie classic', 'App Install',
              'assets/images/app.gif', 'appinstall', false, context),
          _buildCard('Cookie choco', 'Instagram Growth',
              'assets/images/insta.gif', 'instagrowth', false, context)
        ],
    
    );
  }

  Widget _buildCard(String name, String price, String imgPath,
      String userreason, bool active, context) {
    return Opacity(
      opacity: (active) ? 1.0 : 0.5,
      child: Padding(
          padding:
              EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
          child: InkWell(
              onTap: () {
                if (active) {
                  print("Active Service Selected");
                  userReason = userreason;

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OTP()));
                } else {
                  print("Service Selected is not active");
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: kPrimaryColor,
                    content: Text(
                      ' Coming Soon \n This Service is not Active yet ! ',
                      style: TextStyle(fontFamily: "Varela", fontSize: 17.0),
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(seconds: 3),
                  ));
                }
              },
              child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3.0,
                            blurRadius: 5.0)
                      ],
                      color: Colors.white),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Hero(
                        tag: imgPath,
                        child: Container(
                            height: 170.0,
                            width: 175.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(imgPath),
                                    fit: BoxFit.contain)))),
                    Text(price,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: 'Varela',
                            fontSize: 14.0)),
                  ])))),
    );
  }
}

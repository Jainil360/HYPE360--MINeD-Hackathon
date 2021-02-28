import 'package:flutter/material.dart';
import 'Reach.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/MainAppScreen/NavigationBody.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:flutter_auth/services/AddUser.dart';
import 'MainBodyReason.dart';

class CookiePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: new NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 15.0,
      childAspectRatio: 0.7,
      children: <Widget>[
        _buildCard('Cookie mint', 'Cake & Bake', 'assets/images/cake.gif',
            'backer', true, context),
        _buildCard('Cookie mint', 'Electronics Shop', 'assets/images/elec.gif',
            'electronics', true, context),
        _buildCard('Cookie mint', 'Mobile Repairing', 'assets/images/mobile.gif',
            'mobileRepair', true, context),
        _buildCard('Cookie mint', 'Accountant ', 'assets/images/acc.gif',
            'accountant ', false, context),
        _buildCard('Cookie mint', 'Real Estate', 'assets/images/city.gif',
            'realEstate', false, context),
        _buildCard('Cookie mint', 'Interior Designer', 'assets/images/home.gif',
            'interior', false, context),
        _buildCard('Cookie cream', 'Doctor', 'assets/images/doctor.gif',
            'doctor', false, context),
        _buildCard('Cookie classic', 'Gym Owner', 'assets/images/gym.gif',
            'gym', false, context),
        _buildCard('Cookie choco', 'Restaurant Owner', 'assets/images/food.gif',
            'restaurant', false, context)
      ],
    );
  }

  Widget _buildCard(String name, String price, String imgPath,
      String businessType, bool active, context) {
    return Opacity(
      opacity: (active) ? 1.0 : 0.5,
      child: Padding(
          padding:
              EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
          child: InkWell(
              onTap: () {
                if (active) {
                  userBusiness = businessType;

                  print("Active Business Selected");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ReasonPageBody()));
                } else {
                  print("Business selected is inactive");
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: kPrimaryColor,
                    content: Text(
                      ' Coming Soon \n This feature is not Active yet ! ',
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

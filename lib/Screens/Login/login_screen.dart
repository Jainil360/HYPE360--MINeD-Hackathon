import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/MainAppScreen/ProfilePage.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:flutter_auth/Screens/Welcome/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/services/AddUser.dart';
import 'package:flutter_auth/Screens/Demo/selectLocation.dart';

import 'package:flutter_auth/Screens/MainAppScreen/NavigationBody.dart';

import 'package:firebase_auth/firebase_auth.dart';

bool btnState = false;

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String phoneNo;
  String smsCode;
  String verificationId;
  bool otpCheck = false;
  String btnText = "Send OTP";

  // Future<bool> smsCodeDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return new AlertDialog(
  //           title: Text('Enter sms Code'),
  //           content: TextField(
  //             onChanged: (value) {
  //               this.smsCode = value;
  //             },
  //           ),
  //           contentPadding: EdgeInsets.all(10.0),
  //           actions: <Widget>[
  //             new FlatButton(
  //               child: Text('Done'),
  //               onPressed: () {
  //                 FirebaseAuth.instance.currentUser().then((user) {
  //                   if (user != null) {
  //                     print("sucess user verified");
  //                     Navigator.of(context).pop();
  //                   } else {
  //                     print("nope user verified");

  //                     Navigator.of(context).pop();
  //                   }
  //                 });
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      // smsCodeDialog(context).then((value) {
      //   print(smsCode);
      // });
    };
    print(smsCodeSent);
    final PhoneVerificationCompleted verifiedSuccess = (user) {
      setState(() {
        otpCheck = false;
        btnText = "Logging In..";
      });

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SelectLoc()));
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      setState(() {
        btnText = "Too many requests \nTry again after some time";
        otpCheck = false;
      });
      print('otp error =  ${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
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
                "assets/icons/otp.svg",
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      maxLengthEnforced: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Enter Phone number',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontFamily: "Varela", color: Colors.black54)),
                      onChanged: (value) {
                        // if(value == null){
                        //   setState(() {
                        //     btnText = "Invalid Format";
                        //   });
                        // }
                        setState(() {
                          otpCheck = false;
                        });

                        if (value.length == 10) {
                          setState(() {
                            btnState = true;

                            btnText = "send OTP";
                          });
                        } else {
                          setState(() {
                            btnState = false;

                          });
                        }
                        this.phoneNo = "+91" + value;
                      },
                    ),
                  ),
                ),
              ),
              // RoundedButton(
              //   text: "SIGN UP",
              //   color: kPrimaryLightColor,
              //   textColor: Colors.black,
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) {
              //           return SignUpScreen();
              //         },
              //       ),
              //     );
              //   },
              // ),
              SizedBox(
                height: size.height * 0.02,
              ),
              MaterialButton(
                  onPressed: () {
                    if (btnState) {
                      userPhone = phoneNo;

                      print(phoneNo);
                      if (phoneNo == "+91" ||
                          phoneNo == null ||
                          phoneNo.length < 13) {
                        setState(() {
                          btnText = "Invalid Mobile Number";
                        });
                      } else {
                        setState(() {
                          otpCheck = true;
                        });
                        verifyPhone();
                      }
                    } else {
                      setState(() {
                        btnText = "Invalid Mobile Number";
                      });
                    }
                  },
                  child: Container(
                    height: size.height * 0.09,
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      color: (btnState) ? kPrimaryColor : kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (otpCheck)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                  Text(
                                    " Waiting for OTP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Varela",
                                        color: (btnState)
                                            ? Colors.white
                                            : Colors.black54),
                                  ),
                                ],
                              )
                            : Text(
                                btnText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Varela",
                                    color: (btnState)
                                        ? Colors.white
                                        : Colors.black54),
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

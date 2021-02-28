import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import '../../constants.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_auth/services/ReachCounter.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

int _days = 1;
int _budget = minDailyBudget;
int _charges = 300;
int _adspent = minDailyBudget;
int _total = minDailyBudget + 300;
Razorpay _razorpay;

class ReachPage extends StatefulWidget {
  final businessType;

  ReachPage({this.businessType});

  @override
  _ReachPageState createState() => _ReachPageState();
}

class _ReachPageState extends State<ReachPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_fLTsyLHUe5vcx1",
      "amount": 1000,
      "name": "Hype360 India",
      "description": "Confirm your order by paying 10 INR",
      "prefill": {"contact": userPhone, "email": useremail},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Toast.show("SUCCESS: " + response.paymentId, context);
    addNewOrder(_adspent, _days, _total, _charges, userBusiness, _budget,
            response.paymentId)
        .whenComplete(() => {
              _showScaffold("Order Placed Succefully!"),
            });
    setState(() {
      _days = 1;
      _budget = minDailyBudget;
      _charges = 300;
      _adspent = minDailyBudget;
      _total = minDailyBudget + 300;

      lb = minDailyBudget.toDouble();
      ld = 1;
      lr = globallr;
      ur = globalur;

      maxBudget = (((maxReach - 1000) / 10) / maxDays).toDouble();
      budgetSteps = ((maxBudget - minDailyBudget) / (maxDays - 1)).toDouble();
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Toast.show("ERROR: " + response.code.toString(), context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Toast.show("EXTERNAL_WALLET: " + response.walletName.toString(), context);
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                message,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Varela", fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Budget & Duration(In progress)",
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 13.0,
                color: Color(0xFF545D68))),
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Container(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(lr.toString() + " - " + ur.toString(),
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor)),
            ),
          ),
        ),
        Center(
          child: Text('Estimated Reach',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 15.0,
                  color: Color(0xFF545D68))),
        ),
        SizedBox(height: 10.0),
        (userBusiness == "backer")
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Total Birthdays in ' +
                        userLocation +
                        " is = " +
                        birthDays.toString(),
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 15.0,
                        color: Color(0xFF545D68)),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Text(""),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(
              'Total Users in ' +
                  userLocation +
                  " is = " +
                  totalUsers,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 15.0,
                  color: Color(0xFF545D68)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text("Budget In Rupees " + " (" + _budget.toString() + "/Day)",
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 16.0)),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20.0),
            child: FlutterSlider(
              values: [lb],
              max: maxBudget,
              min: minDailyBudget.toDouble(),
              step: FlutterSliderStep(
                step: budgetSteps, // default
              ),
              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                lb = lowerValue;

                setState(() {
                  _budget = lowerValue.toInt();
                });
                List counterList = counter(userBusiness, _budget, _days);
                setReach(counterList);
              },
              handler: FlutterSliderHandler(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  type: MaterialType.canvas,
                  color: kPrimaryColor,
                  elevation: 10,
                  child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('assets/images/inr.png'))),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text("Duration In Days " + " (" + _days.toString() + " Days)",
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 16.0)),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20.0),
            child: FlutterSlider(
              values: [ld],
              max: maxDays.toDouble(),
              min: 1,
              step: FlutterSliderStep(
                step: 1, // default
              ),
              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                ld = lowerValue;
                setState(() {
                  _days = lowerValue.toInt();
                });
                print(_budget);
                List counterList = counter(userBusiness, _budget, _days);
                setReach(counterList);
              },
              handler: FlutterSliderHandler(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  type: MaterialType.canvas,
                  color: kPrimaryColor,
                  elevation: 10,
                  child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset('assets/images/clock.png'))),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ad Expense",
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 16.0)),
                    Text(_adspent.toString(),
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 16.0))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Charges",
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 16.0)),
                    Text("+" + _charges.toString(),
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 16.0))
                  ],
                ),
              ),
              OrDivider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 16.0)),
                    Text(_total.toString(),
                        style: TextStyle(
                            color: Color(0xFF575E67),
                            fontFamily: 'Varela',
                            fontSize: 16.0))
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Center(
            child: RaisedButton(
          elevation: 2,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: kPrimaryColor,
          onPressed: () {
            openCheckout();

            // showAlertDialog(context);
            // print("Budget $_budget");
            // print("Charges $_charges");
            // print("days $_days");
            // print("total $_total");
            // print("ADEXPENSE $_adspent");
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
            child: const Text('Let\'s Grow!', style: TextStyle(fontSize: 20)),
          ),
        )),
        SizedBox(height: 50.0),
      ]),
    );
  }

  void setReach(counterList) {
    setState(() {
      lr = counterList[0];
      ur = counterList[1];
      _adspent = counterList[2];
      _charges = counterList[3];
      _total = counterList[4];
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(fontFamily: "Varela", fontSize: 15, color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = MaterialButton(
      onPressed: () {
        // addNewOrder(_adspent, _days, _total, _charges, userBusiness, _budget)
        //     .whenComplete(() => {
        //           _showScaffold("Order Placed Succefully!"),
        //           Navigator.of(context).pop()
        //         });
        // setState(() {
        //   _days = 1;
        //   _budget = 300;
        //   _charges = 300;
        //   _adspent = 300;
        //   _total = 600;
        //   lb = 300;
        //   ld = 1;

        //   lr = 3000;
        //   ur = 7000;
        // });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Let's Do It",
            style: TextStyle(
                fontFamily: "Varela", fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
    Widget row = Row(
      children: <Widget>[cancelButton, continueButton],
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
          child: Text(
        "Confirm Your Growth",
        style:
            TextStyle(fontFamily: "Varela", fontSize: 20, color: kPrimaryColor),
      )),
      content: Text(
        "It will not cost you money,We will call you to discuss First.",
        style: TextStyle(fontFamily: "Varela"),
      ),
      actions: [row],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

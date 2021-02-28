import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/services/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firestoreInstance = Firestore.instance;


Future isNewUser() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();

  DocumentReference qs = Firestore.instance
      .collection('customerDetails')
      .document(firebaseUser.uid);
  DocumentSnapshot snap = await qs.get();
  (snap.data != null)? newcustomer = false : newcustomer = true;
}

Future addNewUser() async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();

  DocumentReference qs = Firestore.instance
      .collection('customerDetails')
      .document(firebaseUser.uid);
  DocumentSnapshot snap = await qs.get();
  (snap.data != null)
      ? newcustomer = false
      : firestoreInstance
          .collection("customerDetails")
          .document(firebaseUser.uid)
          .setData({
          "custBusiness": userBusiness,
          "custReason" : userReason,
          "custPhone": userPhone,
          "custEmail": firebaseUser.email,
          "custName": firebaseUser.displayName,
          "custOrders": 0,
          "custLocation": userLocation,
          "custOrders": 0,
          "custImp": 0,
          "custReach": 0,
          "custAdspent": 0,
          "custClicks": 0,
          
        }).then((value) => {print("New user ADDED"),initUser()});
  // print(snap.data == null ? 'notexists' : 'we have this doc');
}

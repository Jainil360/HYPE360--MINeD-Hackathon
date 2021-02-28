import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestoreInstance = Firestore.instance;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

var currDt = DateTime.now();

String userBusiness = "NotSelected";
String userReason = "NotSelected";
String userPhone = "NotSelected";
String userLocation = "NotSelected";

String username;
String useremail;
String userimageUrl;
String userId;

int maxReach = 10000;
int birthDays = 1000;
int maxDays = 4;
int minDailyBudget = 100;
int lr = 0, ur = 0;
int globallr = 0, globalur = 0;
String totalUsers;

int custReach = 0;
int custAdspent = 0;
int custImp = 0;
int custClicks = 0;
int custOrders = 0;
bool newcustomer = true;

double lb = 100, ld = 1;
double maxBudget = 200;
double budgetSteps = 100;

// Add the following lines of code inside the
// signInWithGoogle method

Future<FirebaseUser> getCurrentUser() async {
  FirebaseUser user = await _auth.currentUser();
  return user;
}

Future getUserData() async {
  firestoreInstance
      .collection("customerDetails")
      .document(userId)
      .get()
      .then((value) => {
            print("called"),
            custAdspent = value.data['custAdspent'],
            custReach = value.data['custReach'],
            custOrders = value.data['custOrders'],
            custClicks = value.data['custClicks'],
            custImp = value.data['custImp'],
            userBusiness = value.data['custBusiness'],
            userLocation = value.data['custLocation'],
            userPhone = value.data['custPhone'],
            setupReachData()
          });
}

Future setupReachData() async {
  print(userLocation);
  print(userBusiness);
  var month = currDt.month.toString();
  print(month);

  if (userBusiness == "NotSelected" || userLocation == "NotSelected") {
  } else {
    print(userBusiness);
    print(userLocation);

    if (userBusiness == "backer") {
      print("in backer");
      firestoreInstance
          .collection(userBusiness)
          .document(userLocation)
          .get()
          .then((value) => {
                totalUsers = value.data['users'],
                maxReach = value.data[month]['maxReach'],
                birthDays = value.data[month]['birthDays'],
                maxDays = value.data[month]['maxDays'],
                minDailyBudget = value.data[month]['minDailyBudget'],
                ur = value.data[month]['ur'],
                lr = value.data[month]['lr'],
                lb = minDailyBudget.toDouble(),
                ld = 1,
                globallr = lr,
                globalur = ur,
                maxBudget = (((maxReach - 1000) / 10) / maxDays).toDouble(),
                budgetSteps =
                    ((maxBudget - minDailyBudget) / (maxDays - 1)).toDouble(),
                print(maxBudget),
                print(minDailyBudget),
                print(budgetSteps),
                print(maxReach),
              });
    } else if (userBusiness == "accountant") {
      firestoreInstance
          .collection(userBusiness)
          .document(userLocation)
          .get()
          .then((value) => {
                print(value.data),
                totalUsers = value.data['users'],
                maxReach = value.data['maxReach'],
                maxDays = value.data['maxDays'],
                minDailyBudget = value.data['minDailyBudget'],
                ur = value.data['ur'],
                lr = value.data['lr'],
                lb = minDailyBudget.toDouble(),
                ld = 1,
                globallr = lr,
                globalur = ur,
                maxBudget = (((maxReach - 1000) / 10) / maxDays).toDouble(),
                budgetSteps =
                    ((maxBudget - minDailyBudget) / (maxDays - 1)).toDouble(),
                print(maxBudget),
                print(minDailyBudget),
                print(budgetSteps),
                print(maxReach),
              });
    }
  }
}

Future addNewOrder(
    adspent, days, total, charges, business, budget, paymentId) async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();

  firestoreInstance.collection("orderDetails").add({
    "adBudget": adspent,
    "businessType": business,
    "paymentId": paymentId,
    "charges": charges,
    "customerId": firebaseUser.uid,
    "dailyBudget": budget,
    "empId": "",
    "noOfDays": days,
    "orderStatus": "pending",
    "paymenmtStatus": "pending",
    "revenue": total,
    "OrderDate": FieldValue.serverTimestamp(),
    "StartDate": "",
    "Clicks": 0,
    "adSpent": 0,
    "imp": 0,
    "cpc": 0.0,
    "reach": 0
  }).whenComplete(() => {
        Firestore.instance
            .collection('customerDetails')
            .document(userId)
            .updateData({'custOrders': FieldValue.increment(1)})
      });
}

Future initUser() async {
  FirebaseUser _user = await FirebaseAuth.instance.currentUser();
  if (_user == null) {
  } else {
    useremail = _user.email;
    userimageUrl = _user.photoUrl;
    username = _user.displayName;
    userId = _user.uid;
    getUserData();
  }
}

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

// Add the following lines after getting the user
// Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  username = user.displayName;
  useremail = user.email;
  userimageUrl = user.photoUrl;
// Only taking the first part of the name, i.e., First Name
  if (username.contains(" ")) {
    username = username.substring(0, username.indexOf(" "));
  }

  return 'signInWithGoogle succeeded: $user';
}

Future deleteOrder(orderId) async {
  Firestore.instance
      .collection('orderDetails')
      .document(orderId)
      .updateData({'orderStatus': 'canceled'});
}

Future<void> signOut() async {
  await _auth.signOut();
  await googleSignIn.signOut();
}

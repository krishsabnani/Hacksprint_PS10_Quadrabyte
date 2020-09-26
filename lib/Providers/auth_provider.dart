import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hacksprintps10quadrabyte/Models/expense_model.dart';
import 'package:hacksprintps10quadrabyte/Models/user_model.dart';
import 'package:hacksprintps10quadrabyte/Providers/toasts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

   Toasts _toasts = Toasts();
  User user = User();
  bool isLoggedIn = false;
  bool isRefLoading = true;


  Future<bool> createUser(User user, String pass) async {
    _toasts.showToast("Please Wait! This may take few seconds.",18);
    isLoading = true;
    notifyListeners();
    bool isRegistered = false;

    await auth.createUserWithEmailAndPassword(email: user.email, password: pass)
        .then((authResult) async {
      FirebaseUser fbUser = authResult.user;
      if (fbUser != null) {
        user.uid = fbUser.uid;
        user.saveAmt = user.income*user.savePercent/100;
        user.expAmt = user.income-user.saveAmt;
        user.dailyAllowed = user.expAmt/30;
        user.specialEvent = 0;
        print(user.income + user.saveAmt + user.expAmt);

        _toasts.showToast(
            "Registered Successfully", 18);


        createUserDoc(user);
        await Firestore.instance.collection("Expense").document(user.uid).setData({
          "totalMedical" : 0.0,
          "totalMisc" : 0.0,
          "totalGrocery" : 0.0,
          "totalHousehold" : 0.0,
          "totalTransport" : 0.0
        });
        isRegistered = true;
      }
    }).catchError((e) {
      print(e);
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          _toasts.showToast(
              "Email-Id already in use! Please try again with another id.", 18);
        }
      }
      else {
        _toasts.showToast(
            "Something went wrong! Please check your credentials or your network!", 18);
      }
    });
    isLoading = false;
    notifyListeners();
    return isRegistered;
  }

  Future<bool> login(String _email, String _pass) async {
    _toasts.showToast('Please wait! This might take a few seconds', 18);
    isLoading = true;
    notifyListeners();
    bool isLoggedIn = false;
    await auth.signInWithEmailAndPassword(email: _email, password: _pass).then((
        authResult) async {
      FirebaseUser fbUser = authResult.user;
      if (fbUser != null) {
        try {
          await getUserDetails(fbUser.uid).then((value) {
            if (value) {
              print("successsssssssssss");
              _toasts.showToast("Login Successful!",18);
//              storeUserDetailsLocally(fbUser, type);
//              updateLoginStamp(fbUser.uid, type);
              isLoggedIn = true;
            }
            else {
              print(
                  'Something went wrong! Please check your credentials or your network!');
            }
          });
        }
        catch (e) {
          print(e);
          print("Could'nt retrieve data, try again some other time");
        }
      }
    }).catchError((e) {
      _toasts.showToast(
          "Something went wrong! Please check your credentials or your network!", 18);
    });
    isLoading = false;
    notifyListeners();
    return isLoggedIn;
  }

  Future<void> createUserDoc(User user) async {
    Firestore.instance.collection("User").document(user.uid).setData(
        user.toJson());
  }

  Future<bool> getUserDetails(String uid) async {
    bool status = false;
    await Firestore.instance.collection("User").document(uid).get().then((
        snapshot) {
      if (snapshot.exists) {
        user = User.fromJson(snapshot.data);
        notifyListeners();
        status = true;
      }
      else {
        _toasts.showToast("This account does not exist or seems to be removed, please register again to continue!",18);
        status = false;
      }
    });
    return status;
  }

  alterData(ExpenseModel expenseModel) async
  {
    print(user.dailyAllowed);
    print(expenseModel.total);
    if(user.dailyAllowed >= expenseModel.total)
      {
        print("below");
        double diff = user.dailyAllowed - expenseModel.total;
        user.saveAmt = user.saveAmt + diff;
        notifyListeners();
        await Firestore.instance.collection("User").document(user.uid).updateData({
            "saveAmt" : FieldValue.increment(diff)
        });
      }
    else
      { print("exceed");
        double diff = expenseModel.total - user.dailyAllowed;
        user.expAmt = (user.income - diff) - user.saveAmt;
        user.dailyAllowed = user.expAmt/30;
        notifyListeners();
        await Firestore.instance.collection("User").document(user.uid).updateData({
          "dailyAllowed" : user.dailyAllowed,
          "expAmt" : user.expAmt
        });
      }



  }

  Future<bool> logout() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userUid');
      prefs.remove('userType');
      auth.signOut();
      _toasts.showToast(
          "You have been Logged Out!", 18);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }


}
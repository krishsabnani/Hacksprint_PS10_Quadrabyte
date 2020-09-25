import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hacksprintps10quadrabyte/Models/user_model.dart';

class AuthProvider with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  // Toasts _toasts = Toasts();
  User user = User();
  bool isLoggedIn = false;
  bool isRefLoading = true;


  Future<bool> createUser(User user, String pass) async {
    //_toasts.showToast("Please Wait! This may take few seconds.",18);
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

        print(user.income + user.saveAmt + user.expAmt);

//        _toasts.showToast(
//            "Registered Successfully", 18);

        //Write data into firebase


        createUserDoc(user);
        //Send registration email
        isRegistered = true;
      }
    }).catchError((e) {
      print(e);
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//          _toasts.showToast(
//              "Email-Id already in use! Please try again with another id.", 18);
        }
      }
      else {
//        _toasts.showToast(
//            "Something went wrong! Please check your credentials or your network!", 18);
      }
    });
    isLoading = false;
    notifyListeners();
    return isRegistered;
  }

  Future<bool> login(String _email, String _pass, String type) async {
//    _toasts.showToast('Please wait! This might take a few seconds', 18);
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
//              _toasts.showToast("Login Successful!",18);
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
//      _toasts.showToast(
//          "Something went wrong! Please check your credentials or your network!", 18);
    });
    isLoading = false;
    notifyListeners();
    return isLoggedIn;
  }

  Future<void> createUserDoc(User user) async {
    Firestore.instance.collection("User").document(user.uid).setData(
        user.toJson());
  }

  Future<bool> getUserDetails(String uid ) async {
    bool status = false;
    await Firestore.instance.collection("User").document(uid).get().then((
        snapshot) {
      if (snapshot.exists) {
        user = User.fromJson(snapshot.data);
        notifyListeners();
        status = true;
      }
      else {
//        _toasts.showToast("This account does not exist or seems to be removed, please register again to continue!",18);
        status = false;
      }
    });
    return status;
  }

}
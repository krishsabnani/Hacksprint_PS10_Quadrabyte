import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacksprintps10quadrabyte/Pages/opening_screen.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

startTime(AuthProvider auth, context) async {
  await Future.delayed(Duration(seconds: 4));
  _navigate(auth, context);

}

_navigate(AuthProvider auth, context) async {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OpeningView()));
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    startTime(auth, context);
    return Scaffold(
      backgroundColor: Colors.black87,
        body:Container(
          child: Column(
            children: <Widget>[
              Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/14),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                          child: Image.asset("images/logo.jpeg", scale: 1.5,)),

                    ],
                  ),
                ),




              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/6),
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.white),
                  child: new CircularProgressIndicator(),
                )
              ),


            ],
          ),
        )
    );
  }
}

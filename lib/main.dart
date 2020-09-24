import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hacksprintps10quadrabyte/Models/user_model.dart';
import 'package:hacksprintps10quadrabyte/Pages/login_screen.dart';
import 'package:hacksprintps10quadrabyte/Pages/opening_screen.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  User user = new User();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
            providers: [
        ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider()),
        ],

      child: MaterialApp(
       title: 'Flutter Demo',
       theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: OpeningView(),
    ),
    );
  }
}



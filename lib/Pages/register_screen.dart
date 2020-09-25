import 'package:hacksprintps10quadrabyte/Models/user_model.dart';
import 'package:hacksprintps10quadrabyte/Pages/login_screen.dart';
import 'package:hacksprintps10quadrabyte/Pages/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _repasswordController;
  String pass, pass2;
  User user = User();
  //bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    //final logo = Image.asset(
    //  "images/logo.jpeg",
    //  height: 180,
    //  width: 200,
    //);
    final usernameField = TextFormField(
        //enabled: isSubmitting,
        controller: _usernameController,
        onSaved: (val) {
          user.name = val;
        },
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: "Plunjied",
          labelText: "Username",
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.white),
        ));

    final emailField = TextFormField(
        //enabled: isSubmitting,
        onSaved: (val) {
          user.email = val;
        },
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: "email@example.com",
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.white),
        ));

    final passwordField = TextFormField(
        //enabled: isSubmitting,
        onSaved: (val) {
          pass = val;
        },
        controller: _passwordController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "password",
          labelText: "password",
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.white),
        ));
    final income = TextFormField(
        //enabled: isSubmitting,
        onSaved: (val) {
          user.income = double.parse(val);
        },
        controller: _repasswordController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: "Annual income",
          labelText: "Enter your income",
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.white),
        ));
    final target = TextFormField(
        //enabled: isSubmitting,
        controller: _repasswordController,
        onSaved: (val) {
          user.savePercent = double.parse(val);
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: "Percentage of income to be saved",
          labelText: "% to be saved",
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.white),
        ));

    final fields = Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          usernameField,
          emailField,
          passwordField,
          income,
          target,
        ],
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
          minWidth: mq.size.width / 1.2,
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Text(
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            _formKey.currentState.save();
            if (await auth.createUser(user, pass)) {
              print("Registering" + user.email + "10000");
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }
          }),
    );
    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.all(8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Already have an account?",
                style: TextStyle(color: Colors.black)),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.black, decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              padding: EdgeInsets.all(35),
              child: Container(
                height: mq.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //logo,
                    fields,
                    Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: bottom,
                    )
                  ],
                ),
              ))),
    );
  }
}

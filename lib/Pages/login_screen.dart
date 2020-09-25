import 'package:hacksprintps10quadrabyte/Models/user_model.dart';
import 'package:hacksprintps10quadrabyte/Pages/Frontpage.dart';
import 'package:hacksprintps10quadrabyte/Pages/register_screen.dart';
import 'package:hacksprintps10quadrabyte/Pages/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  User user = User();
  String pass;
  //bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    ///final logo = Image.asset(
    /// "images/logo.jpg",
    /// fit: BoxFit.contain,
    ///);

    final emailField = TextFormField(
        //enabled: isSubmitting,
        onSaved: (val){
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

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
            //enabled: isSubmitting,
            onSaved: (val){
              pass = val;
            },
            controller: _passwordController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: "password",
              labelText: "password",
              labelStyle: TextStyle(color: Colors.black),
              hintStyle: TextStyle(color: Colors.white),
            )),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              child: Text(
                "Forgot password",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black),
              ),
              onPressed: () {},
            )
          ],
        )
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          _formKey.currentState.save();
          print(user.email + pass);
          if (await auth.login(
              user.email, pass)) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Home()));
          }
        },
      ),
    );
    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.all(8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Don't have an account?",
                style: TextStyle(color: Colors.black)
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text(
                "Sign up",
                style:TextStyle(color: Colors.black, decoration: TextDecoration.underline),
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
              padding: EdgeInsets.all(36),
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

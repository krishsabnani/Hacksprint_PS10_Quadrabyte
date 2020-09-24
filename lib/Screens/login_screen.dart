import 'package:Homesystem/theme/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  //bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    ///final logo = Image.asset(
    /// "images/logo.jpg",
    /// fit: BoxFit.contain,
    ///);

    final emailField = TextFormField(
        //enabled: isSubmitting,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
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
        /*onPressed: () async {
         try {
            FirebaseUser user =
                (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            )) as FirebaseUser;

            if (user != null) {
              Navigator.of(context).pushNamed(AppRoutes.menu);
            }
          } catch (e) {
            print(e);
            _emailController.text = " ";
            _passwordController.text = " ";
          }

          // Authenticate.
        },
        */
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
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              child: Text(
                "Sign up",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  //bool isSubmitting = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    ///final logo = Image.asset(
    /// "images/logo.jpg",
    /// fit: BoxFit.contain,
    ///);
    final usernameField = TextFormField(
        //enabled: isSubmitting,
        controller: _usernameController,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Plunjied",
          labelText: "Username",
          labelStyle: TextStyle(color: Colors.green),
          hintStyle: TextStyle(color: Colors.white),
        ));

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
          labelStyle: TextStyle(color: Colors.green),
          hintStyle: TextStyle(color: Colors.white),
        ));

    final passwordField = TextFormField(
        //enabled: isSubmitting,
        controller: _passwordController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "password",
          labelText: "password",
          labelStyle: TextStyle(color: Colors.green),
          hintStyle: TextStyle(color: Colors.white),
        ));
    final income = TextFormField(
        //enabled: isSubmitting,
        controller: _repasswordController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Annual income",
          labelText: "Enter your income",
          labelStyle: TextStyle(color: Colors.green),
          hintStyle: TextStyle(color: Colors.white),
        ));
    final target = TextFormField(
        //enabled: isSubmitting,
        controller: _repasswordController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Percentage of income to be saved",
          labelText: "% of money you want to save",
          labelStyle: TextStyle(color: Colors.green),
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
        /*onPressed: () async {
          try {
            FirebaseUser user =
                (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            )) as FirebaseUser;

            if (user != null) {
              UserUpdateInfo updateUser = UserUpdateInfo();
              updateUser.displayName = _usernameController.text;
              user.updateProfile(updateUser);
              Navigator.of(context).pushNamed(AppRoutes.menu);
            }
          } catch (e) {
            _usernameController.text = "";
            _passwordController.text = "";
            _repasswordController.text = "";
            _emailController.text = "";
          }
        },
        */
      ),
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
            Text(
              "Already have an account?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                //Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white, decoration: TextDecoration.underline),
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

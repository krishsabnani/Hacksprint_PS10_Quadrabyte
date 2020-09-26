import 'package:google_fonts/google_fonts.dart';
import 'package:hacksprintps10quadrabyte/Pages/login_screen.dart';
import 'package:hacksprintps10quadrabyte/Pages/register_screen.dart';
import 'package:hacksprintps10quadrabyte/Pages/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OpeningView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "images/logo.jpeg",
      fit: BoxFit.contain,
    );
    final loginButton = Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          colors: [Colors.grey[800], Colors.grey[100]],
          begin: FractionalOffset.topRight,
          end: FractionalOffset.bottomLeft,
        ),
      ),
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
      ),
    );

    final registerButton = Container(


      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          colors: [Colors.grey[800], Colors.grey[100]],
          begin: FractionalOffset.topRight,
          end: FractionalOffset.bottomLeft,
        ),
      ),

      child: MaterialButton(

        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Register",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
      ),
    );
    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 70),
          child: registerButton,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            logo,

            buttons,
          ],
        ),
      ),
    );
  }
}

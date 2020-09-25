import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Toasts {
  Future<bool> showToast(String msg,double size){
    return Fluttertoast.showToast(
        msg: msg,
        fontSize: size,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT
    );
  }

}
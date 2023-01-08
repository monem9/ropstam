import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';

class ToastClass {
  toastFunction(Color color, String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

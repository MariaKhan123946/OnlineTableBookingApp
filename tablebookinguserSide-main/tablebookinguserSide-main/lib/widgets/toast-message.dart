import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

alertDialog(BuildContext context, String msg) {
  showToast(context, msg);
}

void showToast(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.orange,//Theme.of(context).colorScheme.secondary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
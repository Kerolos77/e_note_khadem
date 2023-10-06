import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showToast({
  required String? message,
  Color backgroundColor = Colors.grey,
}) async {
  return await Fluttertoast.showToast(
      msg: message ?? '',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.black,
      fontSize: 16.0);
}

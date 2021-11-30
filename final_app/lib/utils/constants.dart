import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static final Constants _singleton = new Constants._internal();
  static String appName = "Exercise App";
  static Color appThemeColor = Colors.green;

  factory Constants() {
    return _singleton;
  }

  Constants._internal();

  static void showDialog(String message) {
    Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Text('$appName', style: TextStyle(fontWeight: FontWeight.w700),),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK')
          )
        ],
      )
    );
  }

}

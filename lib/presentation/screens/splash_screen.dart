import 'dart:io';

import 'package:e_note_khadem/constants/colors.dart';
import 'package:e_note_khadem/presentation/screens/regisation_screen.dart';
import 'package:e_note_khadem/presentation/screens/users/admin/admin/admin.dart';
import 'package:e_note_khadem/presentation/screens/users/admin/attendance.dart';
import 'package:e_note_khadem/presentation/screens/users/admin/manaheg.dart';
import 'package:e_note_khadem/presentation/screens/users/admin/marathon/marathon.dart';
import 'package:e_note_khadem/presentation/screens/users/khadem/khadem_home.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/conestant.dart';
import '../widgets/global/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashTime = 4;

  @override
  void initState() {
    createDir(); //call your method here
    Future.delayed(Duration(seconds: splashTime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        Widget widget;
        if (constUid != null && constUid != '') {
          if (constUid == 'manaheg') {
            widget = const Manaheg();
          } else if (constUid == 'attendance') {
            widget = const Attendance();
          } else if (constUid == 'marathon') {
            widget = const Marathon();
          } else if (constUid!.contains('admin')) {
            widget = const Admin();
          } else {
            widget = const KhademHome();
          }
        } else {
          widget = Registration();
        }
        return widget;
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo(size: 200),
          defaultText(text: 'Khadem', color: ConstColors.primaryColor)
        ],
      )),
    );
  }

  createDir() async {
    // Directory? baseDir = await getExternalStorageDirectory(); //only for Android
    // Directory baseDir =
    //     await getApplicationDocumentsDirectory(); //works for both iOS and Android
    String dirToBeCreated = "/E Note";
    // for android
    String finalDir = '/storage/emulated/0$dirToBeCreated';
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if (!dirExists && await Permission.storage.request().isGranted) {
      dir.create(
          recursive: true); //pass recursive as true if directory is recursive
    }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissions.
  }
}

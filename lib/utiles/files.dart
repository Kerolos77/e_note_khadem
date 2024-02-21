import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../constants/conestant.dart';

class Files {
  static saveFile(List<int> bytes, String fileName, folderName) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    String path = '$androidDirectory/$folderName/$fileName';
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);
  }
}

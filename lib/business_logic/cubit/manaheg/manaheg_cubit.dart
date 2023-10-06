import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'manaheg_states.dart';

class ManahegCubit extends Cubit<ManahegStates> {
  ManahegCubit() : super(InitialManahegState());

  static ManahegCubit get(context) => BlocProvider.of(context);

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool envFlag = true;
  bool showContainerFlag = false;

  Map<String, dynamic>? user;

  List<String> pdfNames = [];
  List<String> pdfUrl = [];

  void changeEnvFlag(flag) {
    envFlag = flag;
    emit(ChangeManahegState());
  }

  void changeShowContainerFlag(flag) {
    showContainerFlag = flag;
    emit(ChangeManahegState());
  }

  void logout() {
    _firebaseReposatory.logout();
    emit(LogOutSuccessManahegState());
  }

  Future<void> uploadPic() async {
    await FilePicker.platform.pickFiles().then((value) async {
      if (value != null) {
        emit(UploadFileLoadingManahegState());
        File file = File(value!.paths[0]!);
        Reference reference = _storage.ref().child(file.path.split('/').last);
        UploadTask uploadTask = reference.putFile(file);

        await uploadTask.whenComplete(() async {
          var url = await reference.getDownloadURL();
          getMnaheg();
          emit(UploadFileSuccessManahegState());
          // CacheHelper.putData(key: name, value: url.toString());
        }).catchError((error) {
          emit(UploadFileErrorManahegState(error.toString()));
          print(onError);
        });
      }
    });
  }

  void getMnaheg() {
    pdfNames = [];
    pdfUrl = [];
    emit(GetManahegLoadingManahegState());
    _storage.ref().listAll().then((v) {
      v.items.forEach((Reference ref) {
        ref.getDownloadURL().then((value) {
          pdfNames.add(ref.fullPath);
          pdfUrl.add(value);
          if (v.items.last == ref) {
            emit(GetManahegSuccessManahegState());
          }
        });
      });
    }).catchError((error) {});
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      var url = "";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  getApplicationDocumentsDirectory() {}
}

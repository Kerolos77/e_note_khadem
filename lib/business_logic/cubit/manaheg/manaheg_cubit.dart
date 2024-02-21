import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../constants/conestant.dart';
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

  Future<void> uploadFile() async {
    await FilePicker.platform.pickFiles().then((value) async {
      if (value != null) {
        emit(UploadFileLoadingManahegState());
        File file = File(value.paths[0]!);
        String name = file.path
            .split('/')
            .last;
        Reference reference =
        _storage.ref(payId).child(name);
        UploadTask uploadTask = reference.putFile(file);

        await uploadTask.whenComplete(() async {
          getManaheg();
          emit(UploadFileSuccessManahegState(name));
        }).catchError((error) {
          emit(UploadFileErrorManahegState(error.toString()));
          print(onError);
        });
      }
    });
  }

  void getManaheg() {
    pdfNames = [];
    pdfUrl = [];
    Future(() {}).then((value) {
      emit(GetManahegLoadingManahegState());
    });
    _storage.ref(payId).listAll().then((v) {
      for (var ref in v.items) {
        ref.getDownloadURL().then((value) {
          pdfNames.add(ref.name);
          pdfUrl.add(value);
          if (v.items.last == ref) {
            emit(GetManahegSuccessManahegState());
          }
        });
      }
    }).catchError((error) {});
  }

  void deleteFile(String name) {
    Future(() {}).then((value) {
      emit(DeleteFileLoadingManahegState());
    });
    _storage.ref(payId).child(name).delete().then((value) {
      getManaheg();
      emit(DeleteFileSuccessManahegState(name));
    }).catchError((error) {
      emit(DeleteFileErrorManahegState(error.toString()));
    });
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

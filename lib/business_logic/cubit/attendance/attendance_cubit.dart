import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'attendance_states.dart';

class AttendCubit extends Cubit<AttendStates> {
  AttendCubit() : super(InitialAttendState());

  static AttendCubit get(context) => BlocProvider.of(context);

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool lectureFlag = true;
  bool showContainerFlag = false;
  List<dynamic> attendModelList = [];


  Map<String, dynamic>? user;


  void changeLectureFlag(flag) {
    lectureFlag = flag;
    emit(ChangeLectureFlagAttendState());
  }


  void logout() {
    _firebaseReposatory.logout();
    emit(LogOutSuccessAttendState());
  }

  void createUserAttend({required String userId}) {
    emit(CreateAttendLoadingAttendState());
    _firebaseReposatory.createUserAttend(userId: userId).then((value) {
      updateUserAttend(userId: userId);
    }).catchError((onError) {
      emit(CreateAttendErrorAttendState(onError.toString()));
    });
  }

  void updateUserAttend({required String userId}) {
    emit(UpdateAttendLoadingAttendState());
    _firebaseReposatory.getUserData(userId: userId).then((value) {
      user = value.data() as Map<String, dynamic>;
      _firebaseReposatory
          .updateUserAttend(userId: userId, lectureNum: lectureFlag ? '1' : '2')
          .then((value) {
        emit(UpdateAttendSuccessAttendState(
            "${user?['firstName']} ${user?['lastName']}"));
      }).catchError((onError) {
        if (onError
            .toString()
            .contains('Some requested document was not found')) {
          createUserAttend(userId: userId);
        }
      });
    }).catchError((onError) {
      emit(GetUserErrorAttendState(onError.toString()));
    });
  }

}

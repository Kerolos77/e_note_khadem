import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import 'attendance_states.dart';

class AttendCubit extends Cubit<AttendStates> {
  AttendCubit() : super(InitialAttendState());

  static AttendCubit get(context) => BlocProvider.of(context);

  final FirebaseReposatory _firebaseReposatory = FirebaseReposatory();
  static FirebaseFirestore firebase = FirebaseFirestore.instance;
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
        emit(UpdateAttendSuccessAttendState("${user?['fullName']}"));
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

  void getAllUserAttend() {
    emit(GetAllUsersLoadingAttendState());
    // String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String date = "2023-11-17";
    Map<String, int>? attendCount = {
      'total': 0,
      'lecture1': 0,
      'lecture2': 0,
    };
    Map<String, int>? totalAttend = {
      'total': 0,
      'lecture1': 0,
      'lecture2': 0,
    };
    Map<String, Map<String, int>?> attendTeamID = {};
    _firebaseReposatory.getAdminUsers().then((v) {
      for (int i = 0; i < v.docs.length; i++) {
        String userID = v.docs[i].data()['id'];
        String teamID = v.docs[i].data()['teamId'];
        _firebaseReposatory
            .getUserAttendDayData(userId: userID, date: date)
            .then((value) {
          if (value.data() != null && value.data()!.isNotEmpty) {
            attendCount = {
              'total': 0,
              'lecture1': 0,
              'lecture2': 0,
            };
            if (attendTeamID.containsKey(teamID)) {
              attendCount = attendTeamID[teamID];
              if (value.data()?['lecture 1'] != null &&
                  value.data()?['lecture 1'] != '') {
                attendCount?['lecture1'] = (attendCount?['lecture1'])! + 1;
                totalAttend['lecture1'] = (totalAttend['lecture1'])! + 1;
              }
              if (value.data()?['lecture 2'] != null &&
                  value.data()?['lecture 2'] != '') {
                attendCount?['lecture2'] = (attendCount?['lecture2'])! + 1;
                totalAttend['lecture2'] = (totalAttend['lecture2'])! + 1;
              }
              if (value.data()?['lecture 1'] != null &&
                  value.data()?['lecture 1'] != '' &&
                  value.data()?['lecture 2'] != null &&
                  value.data()?['lecture 2'] != '') {
                attendCount?['total'] = (attendCount?['total'])! + 1;
                totalAttend['total'] = (totalAttend['total'])! + 1;
              }
            } else {
              if (value.data()?['lecture 1'] != null &&
                  value.data()?['lecture 1'] != '') {
                attendCount?['lecture1'] = (attendCount?['lecture1'])! + 1;
                totalAttend['lecture1'] = (totalAttend['lecture1'])! + 1;
              }
              if (value.data()?['lecture 2'] != null &&
                  value.data()?['lecture 2'] != '') {
                attendCount?['lecture2'] = (attendCount?['lecture2'])! + 1;
                totalAttend['lecture2'] = (totalAttend['lecture2'])! + 1;
              }
              if (value.data()?['lecture 1'] != null &&
                  value.data()?['lecture 1'] != '' &&
                  value.data()?['lecture 2'] != null &&
                  value.data()?['lecture 2'] != '') {
                attendCount?['total'] = (attendCount?['total'])! + 1;
                totalAttend['total'] = (totalAttend['total'])! + 1;
              }
              attendTeamID.addAll({teamID: attendCount});
            }
          }
          if (i == v.docs.length - 1) {
            attendTeamID.addAll({'Total': totalAttend});
            emit(GetAllUsersSuccessAttendState(attendTeamID));
          }
        }).catchError((error) {
          emit(GetAllUsersErrorAttendState(error));
        });
      }
    });
  }
}

import 'package:e_note_khadem/data/models/user_attend_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/conestant.dart';
import '../../../data/firecase/firebase_reposatory.dart';
import 'view_team_attend_states.dart';

class ViewTeamAttendCubit extends Cubit<ViewTeamAttendStates> {
  ViewTeamAttendCubit() : super(InitialViewTeamAttendState());

  static ViewTeamAttendCubit get(context) => BlocProvider.of(context);

  late UserAttendModel attendModel;
  Map<String, int> attendCount = {
    'total': 0,
    'lecture1': 0,
    'lecture2': 0,
  };

  List<UserAttendModel> userAttendList = [];
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  void getUserAttend(String userId) {
    Future(() {}).then((value) {
      emit(GetUserAttendLoadingViewTeamAttendState());
    });
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    firebaseReposatory.getUserAttendData(userId: userId).then((value) {
      userAttendList = [];
      for (int i = 0; i < value.docs.length; i++) {
        DateTime date = DateTime.parse(value.docs[i].id.toString());
        if (date.compareTo(start) > 0 && date.compareTo(end) < 0) {
          attendModel = UserAttendModel(
              value.docs[i].id,
              value.docs[i].data()['lecture 1'] ?? '-------',
              value.docs[i].data()['lecture 2'] ?? '-------');
          userAttendList.add(attendModel);
          if (attendModel.lecture1 != '-------') {
            attendCount['lecture1'] = attendCount['lecture1']! + 1;
          }
          if (attendModel.lecture1 != '-------') {
            attendCount['lecture2'] = attendCount['lecture2']! + 1;
          }
        }
      }
      attendCount['total'] = userAttendList.length;
      emit(GetUserAttendSuccessViewTeamAttendState());
    });
  }
}

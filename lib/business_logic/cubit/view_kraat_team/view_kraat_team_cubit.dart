import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/conestant.dart';
import '../../../data/firecase/firebase_reposatory.dart';
import '../../../data/local/cache_helper.dart';
import '../../../data/models/kraat_model.dart';
import 'view_kraat_team_states.dart';

class ViewKraatTeamCubit extends Cubit<ViewKraatTeamStates> {
  ViewKraatTeamCubit() : super(InitialViewKraatTeamState());

  static ViewKraatTeamCubit get(context) => BlocProvider.of(context);

  late KraatModel kraatModel;
  int userIndex = 0;
  List<String> names = [];
  Map<String, String> ids = {};
  Map<String, int> kraatCount = {
    'baker': 0,
    'talta': 0,
    'sata': 0,
    'tas3a': 0,
    'grob': 0,
    'noom': 0,
    'ertgalyBaker': 0,
    'ertgalyNom': 0,
    'tnawel': 0,
    'odas': 0,
    'eatraf': 0,
    'soom': 0,
    'oldBible': 0,
    'newBible': 0,
  };

  List<KraatModel> kraatList = [];
  Map<String, dynamic>? user;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  void getTeamUsers() {
    teamId = CacheHelper.getData(key: 'teamId');
    emit(GetUsersLoadingViewKraatTeamState());
    firebaseReposatory.getTeamUsers().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        names.add(
            "${value.docs[i].data()['firstName']} ${value.docs[i].data()['lastName']}");
        ids.addAll({
          "${value.docs[i].data()['firstName']} ${value.docs[i].data()['lastName']}":
              value.docs[i].data()['id'],
        });
      }
      emit(GetUsersSuccessViewKraatTeamState());
    });
  }

  void getUserKraat(String userId) {
    Future(() {}).then((value) {
      emit(GetUserKraatLoadingViewKraatTeamState());
    });
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    kraatList = [];
    firebaseReposatory.getUserKraatData(userId: userId).then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        DateTime date = DateTime.parse(value.docs[i].data()['date']);
        if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
          kraatModel = KraatModel(
            value.docs[i].data()['date'],
            value.docs[i].data()['baker'],
            value.docs[i].data()['talta'],
            value.docs[i].data()['sata'],
            value.docs[i].data()['tas3a'],
            value.docs[i].data()['grob'],
            value.docs[i].data()['noom'],
            value.docs[i].data()['ertgalyBaker'],
            value.docs[i].data()['ertgalyNom'],
            value.docs[i].data()['tnawel'],
            value.docs[i].data()['odas'],
            value.docs[i].data()['eatraf'],
            value.docs[i].data()['soom'],
            value.docs[i].data()['oldBible'],
            value.docs[i].data()['newBible'],
          );
          kraatList.add(kraatModel);
          if (kraatModel.baker) {
            kraatCount['baker'] = kraatCount['baker']! + 1;
          }
          if (kraatModel.talta) {
            kraatCount['talta'] = kraatCount['talta']! + 1;
          }
          if (kraatModel.sata) {
            kraatCount['sata'] = kraatCount['sata']! + 1;
          }
          if (kraatModel.tas3a) {
            kraatCount['tas3a'] = kraatCount['tas3a']! + 1;
          }
          if (kraatModel.grob) {
            kraatCount['grob'] = kraatCount['grob']! + 1;
          }
          if (kraatModel.noom) {
            kraatCount['noom'] = kraatCount['noom']! + 1;
          }
          if (kraatModel.ertgalyBaker) {
            kraatCount['ertgalyBaker'] = kraatCount['ertgalyBaker']! + 1;
          }
          if (kraatModel.ertgalyNom) {
            kraatCount['ertgalyNom'] = kraatCount['ertgalyNom']! + 1;
          }
          if (kraatModel.tnawel) {
            kraatCount['tnawel'] = kraatCount['tnawel']! + 1;
          }
          if (kraatModel.odas) {
            kraatCount['odas'] = kraatCount['odas']! + 1;
          }
          if (kraatModel.eatraf) {
            kraatCount['eatraf'] = kraatCount['eatraf']! + 1;
          }
          if (kraatModel.soom) {
            kraatCount['soom'] = kraatCount['soom']! + 1;
          }
          if (kraatModel.oldBible) {
            kraatCount['oldBible'] = kraatCount['oldBible']! + 1;
          }
          if (kraatModel.newBible) {
            kraatCount['newBible'] = kraatCount['newBible']! + 1;
          }
        }
      }
      emit(GetUserKraatSuccessViewKraatTeamState());
    }).catchError((error) {
      emit(GetUserKraatErrorViewKraatTeamState(error));
    });
  }
}

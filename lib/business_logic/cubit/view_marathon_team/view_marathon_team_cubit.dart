import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../constants/conestant.dart';
import '../../../data/models/marathon_answer_model.dart';
import '../../../presentation/widgets/global/toast.dart';
import 'view_marathon_team_states.dart';

class ViewMarathonTeamCubit extends Cubit<ViewMarathonTeamStates> {
  ViewMarathonTeamCubit() : super(InitialMarathonState());

  static ViewMarathonTeamCubit get(context) => BlocProvider.of(context);

  String? selectedValue;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  List<MarathonAnswerModel> filteredNotoes = [];
  bool sorted = false;
  List<MarathonAnswerModel> sampleNotes = [];

  List<MarathonAnswerModel> sortNotesByModifiedTime(
      List<MarathonAnswerModel> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted = !sorted;
    return notes;
  }

  void onSearchTextChange(String searchText) {
    filteredNotoes = sampleNotes
        .where((note) =>
            note.content.toLowerCase().contains(searchText.toLowerCase()) ||
            note.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    emit(SearchSuccessMarathonState());
  }

  void getMarathonData(String userId) {
    emit(GetUserLoadingMarathonState());
    MarathonAnswerModel marathonAnswerModel;
    sampleNotes = [];
    firebaseReposatory.getMarathonData().then((value) {
      firebaseReposatory
          .getUserMarathonAnswerData(userId: userId)
          .then((answer) {
        for (int i = 0; i < value.docs.length; i++) {
          for (int j = 0; j < answer.docs.length; j++) {
            DateTime start = DateTime.parse(startDate);
            DateTime end = DateTime.parse(endDate);

            if (value.docs[i].data()['id'] == answer.docs[j].id) {
              DateTime date = DateTime.parse(DateFormat('yyyy-MM-dd').format(
                  DateTime.parse(value.docs[i].data()['modifiedTime'])));

              if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
                marathonAnswerModel = MarathonAnswerModel(
                  value.docs[i].data()['id'],
                  value.docs[i].data()['title'],
                  value.docs[i].data()['content'],
                  value.docs[i].data()['modifiedTime'],
                  answer.docs[j].data()['modifiedTime'],
                  answer.docs[j].data()['answer'],
                  answer.docs[j].data()['comment'],
                );
                sampleNotes.add(marathonAnswerModel);
              }
            }
          }
        }
        filteredNotoes = sampleNotes;
        emit(GetUserSuccessMarathonState());
      }).catchError((error) {
        print(error.toString());
        emit(GetUserErrorMarathonState(error.toString()));
      });
    });
  }

  void addComment({
    required String comment,
    required String marathonId,
    required String userId,
  }) {
    // emit(AddCommentLoadingMarathonState());
    firebaseReposatory
        .updateUserMarathonAnswer(
            comment: comment, marathonId: marathonId, userId: userId)
        .then((value) {
      showToast(message: 'Comment Saved');
      // emit(AddCommentSuccessMarathonState());
    }).catchError((error) {
      // emit(AddCommentErrorMarathonState(error.toString()));
    });
  }
}

import 'package:e_note_khadem/data/models/user_report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/conestant.dart';
import '../../../data/firecase/firebase_reposatory.dart';
import '../../../data/models/kraat_model.dart';
import '../../../utiles/generate_excel.dart';
import 'khadem_reports_staetes.dart';

class KhademReportsCubit extends Cubit<KhademReportsStates> {
  KhademReportsCubit() : super(InitialKhademReportsState());

  static KhademReportsCubit get(context) => BlocProvider.of(context);
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  List<UserReportModel> report = [];

  void getReportData() {
    report = [];
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    emit(ReportLoadingReportsState());
    firebaseReposatory.getTeamUsers().then((v) {
      for (int i = 0; i < v.docs.length; i++) {
        int totalMarathon = 0;
        Map<String, int> totalAttend = {
          'total': 0,
          'lec1': 0,
          'lec2': 0,
        };
        Map<String, int> totalKeraat = {
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
        String userID = v.docs[i].data()['id'];
        String userName = v.docs[i].data()['fullName'];
        var (attend, keraat, marathon) =
            firebaseReposatory.makeReport(userId: userID);
        attend.then((attend) {
          keraat.then((keraat) {
            firebaseReposatory.getMarathonData().then((marathonData) {
              marathon.then((marathon) {
                for (int j = 0; j < attend.docs.length; j++) {
                  DateTime date = DateTime.parse(attend.docs[j].id.toString());
                  if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
                    if (attend.docs[j].data()['lecture 1'] != '' &&
                        attend.docs[j].data()['lecture 1'] != null) {
                      totalAttend['lec1'] = (totalAttend['lec1'])! + 1;
                    }
                    if (attend.docs[j].data()['lecture 2'] != '' &&
                        attend.docs[j].data()['lecture 2'] != null) {
                      totalAttend['lec2'] = (totalAttend['lec2'])! + 1;
                    }
                    if (attend.docs[j].data()['lecture 1'] != '' &&
                        attend.docs[j].data()['lecture 2'] != '' &&
                        attend.docs[j].data()['lecture 1'] != null &&
                        attend.docs[j].data()['lecture 2'] != null) {
                      totalAttend['total'] = (totalAttend['total'])! + 1;
                    }
                  }
                }
                for (int j = 0; j < keraat.docs.length; j++) {
                  DateTime date = DateTime.parse(keraat.docs[j].data()['date']);
                  if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
                    KraatModel kraatModel = KraatModel(
                      keraat.docs[j].data()['date'],
                      keraat.docs[j].data()['baker'],
                      keraat.docs[j].data()['talta'],
                      keraat.docs[j].data()['sata'],
                      keraat.docs[j].data()['tas3a'],
                      keraat.docs[j].data()['grob'],
                      keraat.docs[j].data()['noom'],
                      keraat.docs[j].data()['ertgalyBaker'],
                      keraat.docs[j].data()['ertgalyNom'],
                      keraat.docs[j].data()['tnawel'],
                      keraat.docs[j].data()['odas'],
                      keraat.docs[j].data()['eatraf'],
                      keraat.docs[j].data()['soom'],
                      keraat.docs[j].data()['oldBible'],
                      keraat.docs[j].data()['newBible'],
                    );
                    if (kraatModel.baker) {
                      totalKeraat['baker'] = totalKeraat['baker']! + 1;
                    }
                    if (kraatModel.talta) {
                      totalKeraat['talta'] = totalKeraat['talta']! + 1;
                    }
                    if (kraatModel.sata) {
                      totalKeraat['sata'] = totalKeraat['sata']! + 1;
                    }
                    if (kraatModel.tas3a) {
                      totalKeraat['tas3a'] = totalKeraat['tas3a']! + 1;
                    }
                    if (kraatModel.grob) {
                      totalKeraat['grob'] = totalKeraat['grob']! + 1;
                    }
                    if (kraatModel.noom) {
                      totalKeraat['noom'] = totalKeraat['noom']! + 1;
                    }
                    if (kraatModel.ertgalyBaker) {
                      totalKeraat['ertgalyBaker'] =
                          totalKeraat['ertgalyBaker']! + 1;
                    }
                    if (kraatModel.ertgalyNom) {
                      totalKeraat['ertgalyNom'] =
                          totalKeraat['ertgalyNom']! + 1;
                    }
                    if (kraatModel.tnawel) {
                      totalKeraat['tnawel'] = totalKeraat['tnawel']! + 1;
                    }
                    if (kraatModel.odas) {
                      totalKeraat['odas'] = totalKeraat['odas']! + 1;
                    }
                    if (kraatModel.eatraf) {
                      totalKeraat['eatraf'] = totalKeraat['eatraf']! + 1;
                    }
                    if (kraatModel.soom) {
                      totalKeraat['soom'] = totalKeraat['soom']! + 1;
                    }
                    if (kraatModel.oldBible) {
                      totalKeraat['oldBible'] = totalKeraat['oldBible']! + 1;
                    }
                    if (kraatModel.newBible) {
                      totalKeraat['newBible'] = totalKeraat['newBible']! + 1;
                    }
                  }
                }
                for (int i = 0; i < marathonData.docs.length; i++) {
                  for (int j = 0; j < marathon.docs.length; j++) {
                    if (marathonData.docs[i].data()['id'] ==
                        marathon.docs[j].id) {
                      DateTime date = DateTime.parse(DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(
                              marathonData.docs[i].data()['modifiedTime'])));
                      if (date.compareTo(start) >= 0 &&
                          date.compareTo(end) <= 0) {
                        totalMarathon++;
                      }
                    }
                  }
                }
                UserReportModel userReport = UserReportModel(
                  userName,
                  totalAttend['total'].toString(),
                  totalAttend['lec1'].toString(),
                  totalAttend['lec2'].toString(),
                  totalMarathon.toString(),
                  totalKeraat['baker'].toString(),
                  totalKeraat['talta'].toString(),
                  totalKeraat['sata'].toString(),
                  totalKeraat['tas3a'].toString(),
                  totalKeraat['grob'].toString(),
                  totalKeraat['noom'].toString(),
                  totalKeraat['ertgalyBaker'].toString(),
                  totalKeraat['ertgalyNom'].toString(),
                  totalKeraat['tnawel'].toString(),
                  totalKeraat['odas'].toString(),
                  totalKeraat['eatraf'].toString(),
                  totalKeraat['soom'].toString(),
                  totalKeraat['oldBible'].toString(),
                  totalKeraat['newBible'].toString(),
                );
                report.add(userReport);
                if (report.length == v.docs.length) {
                  emit(ReportSuccessReportsState(report));
                  emit(GenerateExcelLoadingReportsState());
                  generateExcel(report).then((value) {
                    emit(GenerateExcelSuccessReportsState());
                  });
                }
              });
            });
          });
        });
      }
    });
  }
}

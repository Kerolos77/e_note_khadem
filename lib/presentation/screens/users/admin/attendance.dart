import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan/scan.dart';

import '../../../../business_logic/cubit/attendance/attendance_cubit.dart';
import '../../../../business_logic/cubit/attendance/attendance_states.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';
  ScanController controller = ScanController();
  bool lightFlag = false;
  bool progressFlag = false;
  static FirebaseFirestore firebase = FirebaseFirestore.instance;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    late AttendCubit cub;
    return BlocProvider(
        create: (BuildContext context) => AttendCubit(),
        child: BlocConsumer<AttendCubit, AttendStates>(
            listener: (BuildContext context, state) {
          if (state is LogOutSuccessAttendState) {
            showToast(
              message: 'Log out Successfully',
            );
            CacheHelper.removeData(key: "user");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Registration(),
                ));
          }
          if (state is UpdateAttendLoadingAttendState ||
              state is CreateAttendLoadingAttendState) {
            progressFlag = true;
            controller.pause();
          }

          if (state is UpdateAttendSuccessAttendState) {
            controller.resume();
            progressFlag = false;
            showToast(
                message:
                    '${state.name} Is Attend Now lecture ${cub.lectureFlag ? '1' : '2'}',
                backgroundColor: Colors.green);
          }

          if (state is UpdateAttendErrorAttendState) {
            progressFlag = false;
            showToast(message: state.error);
            controller.resume();
          }
          if (state is GetUserErrorAttendState) {
            progressFlag = false;
            showToast(
                message: 'user not found', backgroundColor: Colors.redAccent);
            controller.resume();
          }
        }, builder: (BuildContext context, state) {
          cub = AttendCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      width: width,
                      height: height,
                      child: ScanView(
                        controller: controller,
                        scanAreaScale: 1,
                        scanLineColor: Colors.green.shade400,
                        onCapture: (data) {
                          setState(() {
                            cub.updateUserAttend(userId: data);
                            controller.pause();
                          });
                        },
                      ),
                    ),
                    Column(
                      children: [
                        FloatingActionButton(
                          heroTag: "btn1",
                          mini: true,
                          onPressed: () {
                            cub.logout();
                          },
                          child: const Icon(FontAwesomeIcons.signOut),
                        ),
                        FloatingActionButton(
                          heroTag: "btn2",
                          mini: true,
                          onPressed: () {
                            controller.toggleTorchMode();
                            setState(() {
                              lightFlag = !lightFlag;
                            });
                          },
                          child: Icon(lightFlag
                              ? FontAwesomeIcons.solidLightbulb
                              : FontAwesomeIcons.lightbulb),
                        ),
                        FloatingActionButton(
                          heroTag: "btn3",
                          mini: true,
                          onPressed: () {
                            setState(() {
                              cub.changeLectureFlag(!cub.lectureFlag);
                            });
                          },
                          child: defaultText(
                              text: cub.lectureFlag ? '1' : '2',
                              size: 25,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    progressFlag
                        ? Stack(
                            children: [
                              SizedBox(
                                width: width,
                                height: height,
                              ),
                              const Center(child: CircularProgressIndicator()),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            // bottomNavigationBar: ElevatedButton(
            //   child: defaultText(text: 'Total Team Attendace Today'),
            //   onPressed: () {
            //     Map<String, int>? attendCount = {
            //       'total': 0,
            //       'lecture1': 0,
            //       'lecture2': 0,
            //     };
            //     Map<String, Map<String, int>?> attendTeamID = {};
            //     firebase.collection('users').get().then((v) {
            //       for (int i = 0; i < v.docs.length; i++) {
            //         String userID = v.docs[i].data()['id'];
            //         String teamID = v.docs[i].data()['teamId'];
            //         String date =
            //         DateFormat('yyyy-MM-dd').format(DateTime.now());
            //         firebase
            //             .collection('users')
            //             .doc(userID)
            //             .collection('attend')
            //             .doc(date)
            //             .get()
            //             .then((value) {
            //           if (value.data() != null && value.data()!.isNotEmpty) {
            //             if (attendTeamID.containsKey(teamID)) {
            //               attendCount = attendTeamID[teamID];
            //               if (value.data()?['lecture 1'] != null &&
            //                   value.data()?['lecture 1'] != '') {
            //                 attendCount?['lecture1'] =
            //                     (attendCount?['lecture1'])! + 1;
            //               }
            //               if (value.data()?['lecture 2'] != null &&
            //                   value.data()?['lecture 2'] != '') {
            //                 attendCount?['lecture2'] =
            //                     (attendCount?['lecture2'])! + 1;
            //               }
            //               if (value.data()?['lecture 1'] != null &&
            //                   value.data()?['lecture 1'] != '' &&
            //                   value.data()?['lecture 2'] != null &&
            //                   value.data()?['lecture 2'] != '') {
            //                 attendCount?['total'] =
            //                     (attendCount?['total'])! + 1;
            //               }
            //             } else {
            //               if (value.data()?['lecture 1'] != null &&
            //                   value.data()?['lecture 1'] != '') {
            //                 attendCount?['lecture1'] =
            //                     (attendCount?['lecture1'])! + 1;
            //               }
            //               if (value.data()?['lecture 2'] != null &&
            //                   value.data()?['lecture 2'] != '') {
            //                 attendCount?['lecture2'] =
            //                     (attendCount?['lecture2'])! + 1;
            //               }
            //               if (value.data()?['lecture 1'] != null &&
            //                   value.data()?['lecture 1'] != '' &&
            //                   value.data()?['lecture 2'] != null &&
            //                   value.data()?['lecture 2'] != '') {
            //                 attendCount?['total'] =
            //                     (attendCount?['total'])! + 1;
            //               }
            //               attendTeamID.addAll({teamID: attendCount});
            //             }
            //           }
            //         });
            //       }
            //       showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return Dialog(
            //                 child: DataTable(
            //                     columnSpacing: 10,
            //                     columns: [
            //                       DataColumn(
            //                         label: defaultText(
            //                             text: 'Team ID', size: 10),
            //                       ),
            //                       DataColumn(
            //                         label: defaultText(text: 'Total', size: 10),
            //                       ),
            //                       DataColumn(
            //                         label: defaultText(text: '1', size: 10),
            //                       ),
            //                       DataColumn(
            //                         label: defaultText(text: '2', size: 10),
            //                       ),
            //                     ],
            //                     rows: attendTeamID.entries
            //                         .map((entry) =>
            //                         DataRow(
            //                             color: MaterialStateColor.resolveWith(
            //                                     (states) => Colors.black12),
            //                             cells: [
            //                               DataCell(
            //                                 Center(
            //                                   child: defaultText(
            //                                       text: entry.key, size: 13),
            //                                 ),
            //                               ),
            //                               DataCell(
            //                                 Center(
            //                                   child: defaultText(
            //                                       text: entry.value!['total']
            //                                           .toString(),
            //                                       size: 13),
            //                                 ),
            //                               ),
            //                               DataCell(
            //                                 Center(
            //                                   child: defaultText(
            //                                       text: entry
            //                                           .value!['lecture1']
            //                                           .toString(),
            //                                       size: 13),
            //                                 ),
            //                               ),
            //                               DataCell(
            //                                 Center(
            //                                   child: defaultText(
            //                                       text: entry
            //                                           .value!['lecture2']
            //                                           .toString(),
            //                                       size: 13),
            //                                 ),
            //                               ),
            //                             ]))
            //                         .toList()));
            //           });
            //     });
            //   },
            // ),
          );
        }));
  }
}

import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_button.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../business_logic/cubit/attendance/attendance_cubit.dart';
import '../../../../business_logic/cubit/attendance/attendance_states.dart';
import '../../../../constants/colors.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/default_loading.dart';
import '../../../widgets/global/default_snack_bar.dart';
import '../../regisation_screen.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool lightFlag = false;
  bool progressFlag = false;

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var formKey = GlobalKey<FormState>();
  bool flag = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
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
            defaultSnackBar(
              message: 'Log out Successfully',
              context: context,
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
            controller?.pauseCamera();
          }

          if (state is UpdateAttendSuccessAttendState) {
            controller?.resumeCamera();
            progressFlag = false;
            defaultSnackBar(
                context: context,
                message:
                    '${state.name} Is Attend Now lecture ${cub.lectureFlag ? '1' : '2'}',
                backgroundColor: ConstColors.primaryColor);
          }

          if (state is UpdateAttendErrorAttendState) {
            progressFlag = false;
            defaultSnackBar(
              message: state.error,
              context: context,
            );
            controller?.resumeCamera();
          }
          if (state is GetUserErrorAttendState) {
            progressFlag = false;
            defaultSnackBar(
              message: 'user not found',
              backgroundColor: Colors.redAccent,
              context: context,
            );
            controller?.resumeCamera();
          }
          if (state is GetAllUsersLoadingAttendState) {
            controller?.pauseCamera();
            flag = true;
            progressFlag = true;
          }
          if (state is GetAllUsersErrorAttendState) {
            defaultSnackBar(
              message: state.error,
              backgroundColor: Colors.redAccent,
              context: context,
            );
            controller?.resumeCamera();
            progressFlag = false;
          }
          if (state is GetAllUsersSuccessAttendState) {
            flag = false;
            progressFlag = false;
            // controller?.pauseCamera();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      child: SizedBox(
                          height: height,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Center(
                                    child: DataTable(
                                        columnSpacing: 10,
                                        columns: [
                                          DataColumn(
                                            label: defaultText(
                                                text: 'Team ID',
                                                size: 10,
                                                color:
                                                    ConstColors.primaryColor),
                                          ),
                                          DataColumn(
                                            label: defaultText(
                                                text: 'Total',
                                                size: 10,
                                                color:
                                                    ConstColors.primaryColor),
                                          ),
                                          DataColumn(
                                            label: defaultText(
                                                text: 'L 1',
                                                size: 10,
                                                color:
                                                    ConstColors.primaryColor),
                                          ),
                                          DataColumn(
                                            label: defaultText(
                                                text: 'L 2',
                                                size: 10,
                                                color:
                                                    ConstColors.primaryColor),
                                          ),
                                        ],
                                        rows: state.attendTeamID.entries
                                            .map((entry) => DataRow(cells: [
                                                  DataCell(
                                                    Center(
                                                      child: defaultText(
                                                          text: entry.key,
                                                          size: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: defaultText(
                                                          text: entry
                                                              .value!['total']
                                                              .toString(),
                                                          size: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: defaultText(
                                                          text: entry.value![
                                                                  'lecture1']
                                                              .toString(),
                                                          size: 10),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: defaultText(
                                                          text: entry.value![
                                                                  'lecture2']
                                                              .toString(),
                                                          size: 10),
                                                    ),
                                                  ),
                                                ]))
                                            .toList()),
                                  )))));
                }).then((value) {
              controller?.resumeCamera();
            });
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
                      child: QRView(
                        key: qrKey,
                        overlay: QrScannerOverlayShape(),
                        onQRViewCreated: (QRViewController controller) {
                          this.controller = controller;
                          controller.scannedDataStream.listen((scanData) {
                            setState(() {
                              cub.updateUserAttend(userId: scanData.code ?? '');
                              controller.pauseCamera();
                            });
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
                            controller?.toggleFlash();
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
                              defaultLoading()
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: Colors.white,
              height: 40,
              child: ConditionalBuilder(
                condition: (!flag),
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: defaultButton(
                    text: 'Total Attendance Today',
                    width: width,
                    onPressed: () {
                      cub.getAllUserAttend();
                    },
                  ),
                ),
                fallback: (BuildContext context) => defaultLoading(size: 30),
              ),
            ),
          );
        }));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

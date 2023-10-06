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
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
          );
        }));
  }
}

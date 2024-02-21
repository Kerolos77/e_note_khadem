import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_note_khadem/business_logic/cubit/khadem_reports/khadem_reports_cubit.dart';
import 'package:e_note_khadem/business_logic/cubit/khadem_reports/khadem_reports_staetes.dart';
import 'package:e_note_khadem/constants/colors.dart';
import 'package:e_note_khadem/constants/conestant.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_button.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class KhademReports extends StatefulWidget {
  const KhademReports({super.key});

  @override
  State<KhademReports> createState() => _KhademReportsState();
}

class _KhademReportsState extends State<KhademReports> {
  bool flag = false;
  String info = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => KhademReportsCubit(),
      child: BlocConsumer<KhademReportsCubit, KhademReportsStates>(
        listener: (BuildContext context, KhademReportsStates state) {
          print(state);
          if (state is ReportSuccessReportsState) {}
          if (state is GenerateExcelSuccessReportsState) {
            info = ' تم تجهيز الملف ';
            flag = false;
          }
          if (state is ReportLoadingReportsState) {
            info = 'يتم الان تجهيز المعلومات ...';
            flag = true;
          }
          if (state is GenerateExcelLoadingReportsState) {
            info = 'يتم الان تجهيز ملف الاكسيل ...';
          }
          if (state is ReportErrorReportsState) {
            flag = false;
          }
          if (state is GenerateExcelErrorReportsState) {
            flag = false;
          }
        },
        builder: (BuildContext context, KhademReportsStates state) {
          KhademReportsCubit cubit = KhademReportsCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  defaultText(
                      text: 'تذكر دائما ان تحدد تاريخ البدايه والنهايه '),
                  defaultText(text: info, color: ConstColors.primaryColor),
                  ConditionalBuilder(
                    condition: (!flag),
                    builder: (BuildContext context) => defaultButton(
                        text: 'تقرير من  $startDate  الي  $endDate',
                        onPressed: () {
                          cubit.getReportData();
                        },
                        width: width),
                    fallback: (BuildContext context) => Center(
                      child: LoadingAnimationWidget.stretchedDots(
                        color: ConstColors.primaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

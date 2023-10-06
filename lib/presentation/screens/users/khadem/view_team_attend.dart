import 'package:e_note_khadem/constants/conestant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/view_team_attend/view_team_attend_cubit.dart';
import '../../../../business_logic/cubit/view_team_attend/view_team_attend_states.dart';
import '../../../widgets/global/default_text/default_text.dart';

class ViewTeamAttend extends StatefulWidget {
  const ViewTeamAttend({super.key});

  @override
  State<ViewTeamAttend> createState() => _ViewTeamAttendState();
}

class _ViewTeamAttendState extends State<ViewTeamAttend> {
  String? selectedValue;
  bool loadingFlag = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (BuildContext context) =>
            ViewTeamAttendCubit()..getUserAttend(memberID!),
        child: BlocConsumer<ViewTeamAttendCubit, ViewTeamAttendStates>(
          listener: (BuildContext context, ViewTeamAttendStates state) {
            if (state is GetUserAttendLoadingViewTeamAttendState) {
              loadingFlag = true;
            } else {
              loadingFlag = false;
            }
          },
          builder: (BuildContext context, ViewTeamAttendStates state) {
            ViewTeamAttendCubit cub = ViewTeamAttendCubit.get(context);

            return loadingFlag
                ? SizedBox(width: width, child: const LinearProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () async {
                      cub.getUserAttend(memberID!);
                    },
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                cub.userAttendList.isEmpty
                                    ? SizedBox(
                                        width: width,
                                        height: height / 2,
                                        child: Center(
                                            child: defaultText(
                                                text: "NO DATA FOUND ")))
                                    : DataTable(columnSpacing: 30, columns: [
                                        DataColumn(
                                          label: defaultText(
                                              text: 'Date', size: 13),
                                        ),
                                        DataColumn(
                                          label: defaultText(
                                              text: 'lecture 1', size: 13),
                                        ),
                                        DataColumn(
                                          label: defaultText(
                                              text: 'lecture 2', size: 13),
                                        ),
                                      ], rows: [
                                        for (int i = 0;
                                            i < cub.userAttendList.length;
                                            i++)
                                          DataRow(cells: [
                                            DataCell(
                                              Center(
                                                child: defaultText(
                                                    text: cub
                                                        .userAttendList[i].date,
                                                    size: 13),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: defaultText(
                                                    text: cub.userAttendList[i]
                                                        .lecture1,
                                                    size: 13),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: defaultText(
                                                    text: cub.userAttendList[i]
                                                        .lecture2,
                                                    size: 13),
                                              ),
                                            ),
                                          ]),
                                        DataRow(
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.black12),
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: defaultText(
                                                      text: cub
                                                          .attendCount['total']
                                                          .toString(),
                                                      size: 13),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: defaultText(
                                                      text: cub.attendCount[
                                                              'lecture1']
                                                          .toString(),
                                                      size: 13),
                                                ),
                                              ),
                                              DataCell(
                                                Center(
                                                  child: defaultText(
                                                      text: cub.attendCount[
                                                              'lecture2']
                                                          .toString(),
                                                      size: 13),
                                                ),
                                              ),
                                            ])
                                      ])
                              ]),
                        ),
                      ),
                    ),
                  );
          },
        ));
  }
}

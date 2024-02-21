import 'package:e_note_khadem/constants/conestant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/view_kraat_team/view_kraat_team_cubit.dart';
import '../../../../business_logic/cubit/view_kraat_team/view_kraat_team_states.dart';
import '../../../../constants/colors.dart';
import '../../../widgets/global/default_loading.dart';
import '../../../widgets/global/default_text/default_text.dart';

class ViewKraatTeam extends StatefulWidget {
  const ViewKraatTeam({super.key});

  @override
  State<ViewKraatTeam> createState() => _ViewKraatTeamState();
}

class _ViewKraatTeamState extends State<ViewKraatTeam> {
  String? selectedValue;
  bool loadingFlag = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (BuildContext context) =>
            ViewKraatTeamCubit()..getUserKraat(memberID!),
        child: BlocConsumer<ViewKraatTeamCubit, ViewKraatTeamStates>(
          listener: (BuildContext context, ViewKraatTeamStates state) {
            if (state is! GetUserKraatSuccessViewKraatTeamState) {
              loadingFlag = true;
            } else {
              loadingFlag = false;
            }
          },
          builder: (BuildContext context, ViewKraatTeamStates state) {
            ViewKraatTeamCubit cub = ViewKraatTeamCubit.get(context);

            return loadingFlag
                ? SizedBox(
                    width: width,
                    height: height,
                    child: defaultLoading(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      cub.getUserKraat(memberID!);
                    },
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: SizedBox(
                        height: height,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    cub.kraatList.isEmpty
                                        ? SizedBox(
                                            width: width,
                                            height: height / 2,
                                            child: Center(
                                              child: defaultText(
                                                  text: 'NO DATA FOUND'),
                                            ))
                                        : DataTable(
                                            columnSpacing: 20,
                                            columns: [
                                                DataColumn(
                                                  label: Center(
                                                      child: defaultText(
                                                          text: 'تاريخ',
                                                          color: ConstColors
                                                              .primaryColor)),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'باكر',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'تالته',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'سادسه',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'تاسعه',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'غروب',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'نوم',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'ارتجالي باكر',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'ارتجالي نوم',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'تناول',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                    label: defaultText(
                                                        text: 'قداس',
                                                        color: ConstColors
                                                            .primaryColor)),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'اعتراف',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'صوم',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'عهد قديم',
                                                      color: ConstColors
                                                          .primaryColor),
                                                ),
                                                DataColumn(
                                                  label: defaultText(
                                                      text: 'عهد جديد',
                                                      color: ConstColors
                                                          .primaryColor),
                                                )
                                              ],
                                            rows: [
                                                for (int i = 0;
                                                    i < cub.kraatList.length;
                                                    i++)
                                                  DataRow(cells: [
                                                    DataCell(defaultText(
                                                        text: cub
                                                            .kraatList[i].date
                                                            .toString(),
                                                        color: ConstColors
                                                            .primaryColor)),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .baker))),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .talta))),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .sata))),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .tas3a))),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .grob))),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .noom))),
                                                    DataCell(Center(
                                                      child: icon(cub
                                                          .kraatList[i]
                                                          .ertgalyBaker),
                                                    )),
                                                    DataCell(Center(
                                                      child: icon(cub
                                                          .kraatList[i]
                                                          .ertgalyNom),
                                                    )),
                                                    DataCell(Center(
                                                      child: icon(cub
                                                          .kraatList[i].tnawel),
                                                    )),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .odas))),
                                                    DataCell(Center(
                                                      child: icon(cub
                                                          .kraatList[i].eatraf),
                                                    )),
                                                    DataCell(Center(
                                                        child: icon(cub
                                                            .kraatList[i]
                                                            .soom))),
                                                    DataCell(Center(
                                                      child: icon(cub
                                                          .kraatList[i]
                                                          .oldBible),
                                                    )),
                                                    DataCell(Center(
                                                      child: icon(cub
                                                          .kraatList[i]
                                                          .newBible),
                                                    )),
                                                  ]),
                                                DataRow(
                                                    color: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors.black12),
                                                    cells: [
                                                      DataCell(Center(
                                                          child: defaultText(
                                                              text: 'Total',
                                                              color: ConstColors
                                                                  .primaryColor))),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'baker']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'talta']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'sata']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'tas3a']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'grob']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'noom']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'ertgalyBaker']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'ertgalyNom']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'tnawel']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'odas']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'eatraf']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'soom']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'oldBible']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                      DataCell(Center(
                                                        child: defaultText(
                                                            text: cub
                                                                .kraatCount[
                                                                    'newBible']
                                                                .toString(),
                                                            color: ConstColors
                                                                .primaryColor),
                                                      )),
                                                    ])
                                              ])
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ));
  }

  Widget icon(bool flag) {
    return Icon(
      flag ? Icons.done : Icons.close,
      color: flag ? Colors.green : Colors.red,
    );
  }
}

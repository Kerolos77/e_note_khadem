import 'package:e_note_khadem/constants/conestant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/cubit/view_kraat_team/view_kraat_team_cubit.dart';
import '../../../../business_logic/cubit/view_kraat_team/view_kraat_team_states.dart';
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
                ? SizedBox(width: width, child: const LinearProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () async {
                      cub.getUserKraat(memberID!);
                    },
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: SizedBox(
                        height: height,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                              text: 'تاريخ')),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'باكر'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'تالته'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'سادسه'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'تاسعه'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'غروب'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'نوم'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'ارتجالي باكر'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'ارتجالي نوم'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'تناول'),
                                                    ),
                                                    DataColumn(
                                                        label: defaultText(
                                                            text: 'قداس')),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'اعتراف'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'صوم'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'عهد قديم'),
                                                    ),
                                                    DataColumn(
                                                      label: defaultText(
                                                          text: 'عهد جديد'),
                                                    )
                                                  ],
                                                rows: [
                                                    for (int i = 0;
                                                        i <
                                                            cub.kraatList
                                                                .length;
                                                        i++)
                                                      DataRow(cells: [
                                                        DataCell(defaultText(
                                                            text: cub
                                                                .kraatList[i]
                                                                .date
                                                                .toString())),
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
                                                              .kraatList[i]
                                                              .tnawel),
                                                        )),
                                                        DataCell(Center(
                                                            child: icon(cub
                                                                .kraatList[i]
                                                                .odas))),
                                                        DataCell(Center(
                                                          child: icon(cub
                                                              .kraatList[i]
                                                              .eatraf),
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
                                                            .resolveWith(
                                                                (states) => Colors
                                                                    .black12),
                                                        cells: [
                                                          DataCell(Center(
                                                              child: defaultText(
                                                                  text:
                                                                      'Total'))),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'baker']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'talta']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'sata']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'tas3a']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'grob']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'noom']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'ertgalyBaker']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'ertgalyNom']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'tnawel']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'odas']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'eatraf']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'soom']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'oldBible']
                                                                    .toString()),
                                                          )),
                                                          DataCell(Center(
                                                            child: defaultText(
                                                                text: cub
                                                                    .kraatCount[
                                                                        'newBible']
                                                                    .toString()),
                                                          )),
                                                        ])
                                                  ])
                                      ]),
                                ),
                              ),
                            ),
                          ],
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

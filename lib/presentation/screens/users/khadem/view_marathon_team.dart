import 'package:e_note_khadem/business_logic/cubit/view_marathon_team/view_marathon_team_cubit.dart';
import 'package:e_note_khadem/constants/conestant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../business_logic/cubit/view_marathon_team/view_marathon_team_states.dart';
import '../../../../constants/colors.dart';
import '../../../widgets/global/default_button.dart';
import '../../../widgets/global/default_loading.dart';
import '../../../widgets/global/default_text/default_text.dart';
import '../../../widgets/global/default_text_field.dart';

class ViewTeamMaraton extends StatefulWidget {
  const ViewTeamMaraton({super.key});

  @override
  State<ViewTeamMaraton> createState() => _ViewTeamMaratonState();
}

class _ViewTeamMaratonState extends State<ViewTeamMaraton> {
  bool loadingFlag = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (BuildContext context) =>
            ViewMarathonTeamCubit()..getMarathonData(memberID!),
        child: BlocConsumer<ViewMarathonTeamCubit, ViewMarathonTeamStates>(
            listener: (BuildContext context, ViewMarathonTeamStates state) {
          if (state is! GetUserSuccessMarathonState) {
            loadingFlag = true;
          } else {
            loadingFlag = false;
          }
        }, builder: (BuildContext context, ViewMarathonTeamStates state) {
          ViewMarathonTeamCubit cubit = ViewMarathonTeamCubit.get(context);
          // cubit.filteredNotoes = cubit.sortNotesByModifiedTime(cubit.filteredNotoes);
          return loadingFlag
              ? SizedBox(
                  width: width,
                  height: height,
                  child: defaultLoading(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    cubit.getMarathonData(memberID!);
                  },
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      elevation: 0,
                      title: TextField(
                        onChanged: cubit.onSearchTextChange,
                        style: const TextStyle(
                            fontSize: 16, color: ConstColors.grey),
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                            hintText: "Search ...",
                            hintStyle: const TextStyle(color: ConstColors.grey),
                            prefixIcon: const Icon(Icons.search,
                                color: ConstColors.grey),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            )),
                      ),
                      backgroundColor: Colors.white,
                      actions: [
                        Center(
                            child: defaultText(
                                text: cubit.filteredNotoes.length.toString())),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                cubit.filteredNotoes =
                                    cubit.sortNotesByModifiedTime(
                                        cubit.filteredNotoes);
                              });
                            },
                            padding: const EdgeInsets.all(0),
                            icon: Icon(
                              cubit.sorted
                                  ? FontAwesomeIcons.arrowDownWideShort
                                  : FontAwesomeIcons.arrowDownShortWide,
                              color: ConstColors.primaryColor,
                            )),
                      ],
                    ),
                    body: CustomScrollView(
                      slivers: <Widget>[
                        cubit.filteredNotoes.isEmpty
                            ? SliverToBoxAdapter(
                                child: Center(
                                child: defaultText(text: 'NO DATA FOUND'),
                              ))
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: cubit.filteredNotoes.length,
                                    (BuildContext context, int index) {
                                  TextEditingController commentController =
                                      TextEditingController();
                                  commentController.text =
                                      cubit.filteredNotoes[index].comment;
                                  return Card(
                                      margin: const EdgeInsets.only(
                                          bottom: 5, right: 5, left: 5),
                                      color: Colors.greenAccent.shade100,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: RichText(
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                    text:
                                                        '${cubit.filteredNotoes[index].title} \n',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.5,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: cubit
                                                            .filteredNotoes[
                                                                index]
                                                            .content,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 11,
                                                            height: 1.5),
                                                      )
                                                    ]),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  cubit.filteredNotoes[index]
                                                      .modifiedTime,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: RichText(
                                                maxLines: 10,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                    text: 'Answer \n',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: cubit
                                                            .filteredNotoes[
                                                                index]
                                                            .answer,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 12,
                                                            height: 1.5),
                                                      )
                                                    ]),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  cubit.filteredNotoes[index]
                                                      .modifiedAnswerDate,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DefaultTextField(
                                              control: commentController,
                                              type: TextInputType.multiline,
                                              text: 'Type Your Comment',
                                              maxLines: null,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            defaultButton(
                                              text: 'Comment',
                                              onPressed: () {
                                                if (commentController.text !=
                                                    '') {
                                                  cubit.addComment(
                                                    context: context,
                                                    comment:
                                                        commentController.text,
                                                    userId: memberID!,
                                                    marathonId: cubit
                                                        .filteredNotoes[index]
                                                        .id,
                                                  );
                                                }
                                              },
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            )
                                          ],
                                        ),
                                      ));
                                }),
                              ),
                      ],
                    ),
                  ),
                );
        }));
  }
}

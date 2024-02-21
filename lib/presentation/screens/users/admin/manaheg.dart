import 'package:e_note_khadem/presentation/widgets/global/default_loading.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../business_logic/cubit/manaheg/manaheg_cubit.dart';
import '../../../../business_logic/cubit/manaheg/manaheg_states.dart';
import '../../../../constants/colors.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/default_snack_bar.dart';
import '../../regisation_screen.dart';

class Manaheg extends StatefulWidget {
  const Manaheg({super.key});

  @override
  State<Manaheg> createState() => _ManahegState();
}

class _ManahegState extends State<Manaheg> {
  bool progressFlag = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    late ManahegCubit cub;
    return BlocProvider(
      create: (BuildContext context) => ManahegCubit()..getManaheg(),
      child: BlocConsumer<ManahegCubit, ManahegStates>(
          listener: (BuildContext context, ManahegStates state) {
        if (state is LogOutSuccessManahegState) {
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
        if (state is GetManahegLoadingManahegState) {
          progressFlag = true;
        }
        if (state is GetManahegSuccessManahegState) {
          progressFlag = false;
        }
        if (state is UploadFileLoadingManahegState) {
          progressFlag = true;
        }
        if (state is UploadFileSuccessManahegState) {
          progressFlag = false;
          defaultSnackBar(
            message: '${state.name} Uploaded Successfully',
            context: context,
          );
        }
        if (state is UploadFileErrorManahegState) {
          progressFlag = false;
          defaultSnackBar(
            message: state.error,
            context: context,
          );
        }
        if (state is DeleteFileLoadingManahegState) {
          progressFlag = true;
        }
        if (state is DeleteFileSuccessManahegState) {
          progressFlag = false;
          defaultSnackBar(
            message: '${state.name} Deleted Successfully',
            context: context,
          );
        }
        if (state is DeleteFileErrorManahegState) {
          progressFlag = false;
          defaultSnackBar(
            message: state.error,
            context: context,
          );
        }
      }, builder: (BuildContext context, ManahegStates state) {
        cub = ManahegCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  cub.logout();
                },
                icon: const Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20,
                  color: ConstColors.primaryColor,
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cub.uploadFile();
            },
            child: const Icon(FontAwesomeIcons.add),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: cub.pdfNames.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) => Card(
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.picture_as_pdf,
                                    size: 30,
                                    color: ConstColors.primaryColor,
                                  ),
                                ),
                                Expanded(
                                    child: defaultText(
                                        text: cub.pdfNames[index],
                                        overflow: false)),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return AlertDialog(
                                            title: const Icon(
                                              FontAwesomeIcons.trashCan,
                                              color: Colors.redAccent,
                                            ),
                                            content: defaultText(
                                                overflow: false,
                                                text:
                                                    'Are you sure To Delete ${cub.pdfNames[index]}?'),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        dialogContext);
                                                  },
                                                  child: defaultText(
                                                      text: 'Cancel',
                                                      color: ConstColors
                                                          .primaryColor)),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(dialogContext);
                                                  cub.deleteFile(
                                                      cub.pdfNames[index]);
                                                },
                                                child: defaultText(
                                                    text: 'Delete',
                                                    color: Colors.redAccent),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.trashCan,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            ),
                            onTap: () async {
                              await launch(cub.pdfUrl[index]);
                            },
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: cub.pdfNames.length,
                      )
                    : Center(
                        child: defaultText(
                        text: 'No Manaheg Found',
                      )),
              ),
              progressFlag
                  ? Card(
                      elevation: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultText(text: 'wait until loading complete '),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultLoading(),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_note_khadem/constants/colors.dart';
import 'package:e_note_khadem/presentation/screens/users/khadem/view_marathon_team.dart';
import 'package:e_note_khadem/presentation/screens/users/khadem/view_team_attend.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../constants/conestant.dart';
import '../../../../data/firecase/firebase_reposatory.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/global/toast.dart';
import '../../regisation_screen.dart';
import 'view_kraat_team.dart';

class KhademHome extends StatefulWidget {
  const KhademHome({Key? key}) : super(key: key);

  @override
  State<KhademHome> createState() => _KhademHomeState();
}

class _KhademHomeState extends State<KhademHome> {
  var screens = [
    const ViewKraatTeam(),
    const ViewTeamMaraton(),
    const ViewTeamAttend(),
  ];
  Map<String, String> ids = {};
  List<String> names = [];
  String? selectedValue;
  bool dateFlag = false;
  bool flag = false;

  var screenIndex = 0;
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();

  @override
  void initState() {
    // TODO: implement initState
    getTeamUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              dateFlag = true;
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      content: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        viewSpacing: 20,
                        selectionMode: DateRangePickerSelectionMode.range,
                        selectionShape: DateRangePickerSelectionShape.rectangle,
                        initialSelectedRange: PickerDateRange(
                          DateTime.parse(startDate),
                          DateTime.parse(endDate),
                        ),
                      ),
                    );
                  }).then((value) {
                dateFlag = false;

                setState(() {});
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                defaultText(text: startDate, size: 10),
                defaultText(text: endDate, size: 10),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20,
              color: Colors.green,
            ),
          )
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            names.isNotEmpty
                ? DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    hint: defaultText(text: 'Select Team Member', size: 10),
                    items: names
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: defaultText(text: item, size: 10),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Team Member.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      memberID = ids[value];
                      selectedValue = value.toString();
                      setState(() {});
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 20,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  )
                : flag
                    ? defaultText(text: 'No Team Member')
                    : const LinearProgressIndicator(),
            GestureDetector(
              child: defaultText(
                  text: 'Team ID: ${teamId!}',
                  color: ConstColors.green,
                  size: 10),
              onDoubleTap: () {
                Clipboard.setData(ClipboardData(text: teamId!)).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Team ID is copied")));
                });
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.file,
              size: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bookBible,
              size: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.fingerprint,
              size: 20,
            ),
            label: '',
          ),
        ],
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        currentIndex: screenIndex,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.green,
        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
        elevation: 0,
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: selectedValue == null
            ? Center(
                child: defaultText(text: 'Please select Team Member'),
              )
            : dateFlag
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : screens[screenIndex],
      ),
    );
  }

  void logout() {
    FirebaseAuth.instance.signOut();
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

  void getTeamUsers() {
    flag = false;
    teamId = CacheHelper.getData(key: 'teamId');
    setState(() {});
    firebaseReposatory.getTeamUsers().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        // userList.add(value.docs[i].data());
        names.add(
            "${value.docs[i].data()['firstName']} ${value.docs[i].data()['lastName']}");
        ids.addAll({
          "${value.docs[i].data()['firstName']} ${value.docs[i].data()['lastName']}":
              value.docs[i].data()['id'],
        });
      }
      if (names.isEmpty) {
        flag = true;
      }
      setState(() {});
    }).catchError((error) {
      print('error--------------');
    });
  }

  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = DateFormat('yyyy-MM-dd').format(args.value.startDate);
        endDate = DateFormat('yyyy-MM-dd')
            .format(args.value.endDate ?? args.value.startDate);
      }
    });
  }
}

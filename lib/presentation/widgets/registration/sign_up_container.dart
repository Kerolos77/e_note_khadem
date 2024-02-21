import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_note_khadem/constants/colors.dart';
import 'package:e_note_khadem/data/firecase/firebase_reposatory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

import '../../../utiles/id.dart';
import '../global/default_button.dart';
import '../global/default_loading.dart';
import '../global/default_text/default_text.dart';
import '../global/default_text_field.dart';

Widget signUpContainer({
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  required TextEditingController fullNameController,
  required TextEditingController birthDateController,
  required TextEditingController teamIdController,
  required TextEditingController phoneController,
  required TextEditingController payIdController,
  required void Function()? onPressed,
  required BuildContext context,
  required void Function(bool) onToggle,
  required void Function()? verifyOnPressed,
  required bool state,
  required Key formKey,
  required bool flag,
}) {
  if (teamIdController.text.isEmpty) {
    teamIdController.text = ID.createId();
  }
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  return Form(
      key: formKey,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultText(text: 'Gender', size: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultText(text: 'Male', size: 14, color: ConstColors.male),
                FlutterSwitch(
                    value: state,
                    borderRadius: 25.0,
                    padding: 2.0,
                    height: 25,
                    activeColor: ConstColors.female,
                    inactiveColor: ConstColors.male,
                    onToggle: onToggle),
                defaultText(
                    text: 'Female', size: 14, color: ConstColors.female),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            DefaultTextField(
              control: fullNameController,
              text: 'Full Name',
              type: TextInputType.name,
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please enter your Full name';
                }
                return null;
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            DefaultTextField(
              control: phoneController,
              text: 'WhatsApp Number',
              type: TextInputType.phone,
              validate: (value) {
                if (value.isEmpty || value.toString().length != 11) {
                  return 'Please enter a valid WhatsApp Number';
                }
                return null;
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DefaultTextField(
                  control: emailController,
                  text: 'E-mail',
                  type: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                // TextButton(
                //     onPressed: verifyOnPressed,
                //     child: defaultText(
                //         text: 'verify Email', color: Colors.blue, size: 12)),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Row(
              children: [
                Expanded(
                  child: DefaultTextField(
                    control: birthDateController,
                    readOnly: true,
                    text: 'Birth Date',
                    type: TextInputType.datetime,
                    onTape: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: ConstColors.primaryColor,
                                // header background color
                                onPrimary: Colors.black,
                                // header text color
                                onSurface: Colors.black, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: Colors.black, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      ).then((date) {
                        birthDateController.text =
                            DateFormat('yyyy-MM-dd').format(date!);
                      }).catchError((error) {
                        birthDateController.text = '';
                      });
                    },
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please select your Birth Date';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                Expanded(
                  flex: 2,
                  child: DefaultTextField(
                    control: teamIdController,
                    text: 'Team ID',
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your Team ID';
                      } else if (value.toString().length < 8) {
                        return 'Please enter correct Team ID';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 30,
            // ),
            // DefaultTextField(
            //   control: payIdController,
            //   text: 'Pay ID',
            //   type: TextInputType.text,
            //   validate: (value) {
            //     firebaseReposatory.verifyPayId(value).then((value) {
            //       if (value.data() == null) {
            //         return 'Please enter a valid Pay ID';
            //       }
            //       return null;
            //     });
            //   },
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            DefaultTextField(
                isPassword: true,
                control: passwordController,
                text: 'Password',
                type: TextInputType.emailAddress,
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            DefaultTextField(
                isPassword: true,
                control: confirmPasswordController,
                text: 'Confirm Password',
                type: TextInputType.emailAddress,
                validate: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            ConditionalBuilder(
              condition: (!flag),
              builder: (BuildContext context) => defaultButton(
                  width: MediaQuery.of(context).size.width,
                  text: "Sign Up",
                  onPressed: onPressed),
              fallback: (BuildContext context) => defaultLoading(),
            ),
          ],
        ),
      ));
}

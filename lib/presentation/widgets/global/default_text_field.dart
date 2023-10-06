import 'package:e_note_khadem/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultTextField({
  required TextEditingController control,
  required TextInputType type,
  required String text,
  bool readOnly = false,
  bool obscure = false,
  ValueChanged? onSubmit,
  ValueChanged? onchange,
  GestureTapCallback? onTape,
  FormFieldValidator? validate,
  Color iconColor = Colors.black,
  var maxLines = 1,
}) {
  return TextFormField(
    readOnly: readOnly,
    controller: control,
    keyboardType: type,
    obscureText: obscure,
    onChanged: onchange,
    onTap: onTape,
    validator: validate,
    maxLines: maxLines,
    onFieldSubmitted: onSubmit,
    cursorColor: Colors.black,
    style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
    decoration: InputDecoration(
      contentPadding:
          const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      labelText: text,
      labelStyle: GoogleFonts.roboto(
          fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
      focusedBorder: OutlineInputBorder(
        gapPadding: 1.0,
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: ConstColors.green,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: ConstColors.green,
          width: 1.0,
        ),
      ),
      errorStyle: const TextStyle(
        fontSize: 10,
        color: ConstColors.green,
      ),
    ),
  );
}

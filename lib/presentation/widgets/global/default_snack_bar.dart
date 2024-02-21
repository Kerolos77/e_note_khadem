import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void defaultSnackBar({
  required String message,
  required BuildContext context,
  Color backgroundColor = Colors.black,
}) async {
  return FloatingSnackBar(
    message: message,
    context: context,
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    textStyle: GoogleFonts.roboto(
        fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
  );
}

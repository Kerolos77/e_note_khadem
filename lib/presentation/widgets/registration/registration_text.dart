import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget registrationText({
  required String text,
  required bool isClick,
  required GestureTapCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: isClick
                      ? const Color.fromRGBO(26, 188, 0, 1)
                      : const Color.fromRGBO(0, 0, 0, 0),
                  width: 3))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          text,
          style: GoogleFonts.roboto(
              color: isClick
                  ? const Color.fromRGBO(26, 188, 0, 1)
                  : const Color.fromRGBO(138, 138, 138, 1),
              fontSize: 18),
        ),
      ),
    ),
  );
}

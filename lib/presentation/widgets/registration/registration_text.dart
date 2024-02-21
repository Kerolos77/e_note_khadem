import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/colors.dart';

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
                  color:
                      isClick ? ConstColors.primaryColor : ConstColors.noColor,
                  width: 3))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(
          text,
          style: GoogleFonts.roboto(
              color: isClick ? ConstColors.primaryColor : ConstColors.grey,
              fontSize: 18),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultText({
  required String text,
  double size = 15,
  Color color = Colors.black,
  bool overflow = true,
}) {
  return Text(
    text,

    overflow: overflow ? TextOverflow.ellipsis : TextOverflow.clip,
    style: GoogleFonts.roboto(
        fontSize: size, color: color, fontWeight: FontWeight.w500),
  );
}
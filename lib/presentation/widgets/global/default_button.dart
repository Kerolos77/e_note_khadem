import 'package:e_note_khadem/constants/colors.dart';
import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required String text,
  required void Function()? onPressed,
  required double width,
  Color backgroundColor = ConstColors.primaryColor,
}) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
        child: defaultText(text: text, size: 14, color: Colors.white)),
  );
}

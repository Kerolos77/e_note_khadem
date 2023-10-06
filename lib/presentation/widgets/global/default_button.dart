import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required String text,
  required void Function()? onPressed,
  required double width,
}) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
        onPressed: onPressed,
        child: defaultText(text: text, size: 14, color: Colors.white)),
  );
}

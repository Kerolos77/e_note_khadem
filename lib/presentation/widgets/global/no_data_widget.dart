import 'package:e_note_khadem/presentation/widgets/global/default_text/default_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/colors.dart';

Widget noData(
  double width,
  double height,
) {
  return SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        const Icon(
          FontAwesomeIcons.notdef,
          color: ConstColors.primaryColor,
        ),
        defaultText(text: 'No Data Found'),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget logo({required double size}) {
  return SvgPicture.asset(
    "assets/images/logo_digital.svg",
    width: size,
    height: size,
  );
}

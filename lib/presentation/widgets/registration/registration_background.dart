import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/colors.dart';

Widget registrationBackground({
  required BuildContext context,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        SvgPicture.asset(
          "assets/images/background_login_top.svg",
          color: ConstColors.primaryColor,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SvgPicture.asset(
                "assets/images/background_login_bottom.svg",
                color: ConstColors.primaryColor,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

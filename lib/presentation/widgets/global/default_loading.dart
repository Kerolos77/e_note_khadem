import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constants/colors.dart';

Widget defaultLoading({
  double size = 50,
}) {
  return Center(
    child: LoadingAnimationWidget.stretchedDots(
      color: ConstColors.primaryColor,
      size: size,
    ),
  );
}

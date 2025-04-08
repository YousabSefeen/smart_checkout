import 'package:flutter/material.dart';

import '../../../../../../../../../Core/App colors manager/app_colors_manager.dart';

class CustomHalfCircle extends StatelessWidget {
  final bool isLeftPosition;

  const CustomHalfCircle({super.key, required this.isLeftPosition});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: isLeftPosition
            ? const BorderRadius.only(
                bottomRight: Radius.circular(100),
                topRight: Radius.circular(100),
              )
            : const BorderRadius.only(
                bottomLeft: Radius.circular(100),
                topLeft: Radius.circular(100),
              ),
        gradient: LinearGradient(
          colors: isLeftPosition
              ? AppColorsManagers.colorsLeftPosition
              : AppColorsManagers.colorsRightPosition,
        ),
      ),
    );
  }
}

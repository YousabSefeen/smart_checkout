import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../Core/App colors manager/app_colors_manager.dart';

class CustomShadowHeader extends StatelessWidget {
  const CustomShadowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.20,
      decoration: ShapeDecoration(
          color: AppColorsManagers.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
              bottomLeft: Radius.circular(70.r),
              bottomRight: Radius.circular(70.r),
            ),
          ),
          shadows: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 2,
              blurStyle: BlurStyle.normal,
            ),
            BoxShadow(
              color: AppColorsManagers.blueShadowHeader,
              blurRadius: 25,
              offset: Offset(0, 1),
              spreadRadius: 25,
              blurStyle: BlurStyle.normal,
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 2,
              blurStyle: BlurStyle.normal,
            ),
          ]),
    );
  }
}

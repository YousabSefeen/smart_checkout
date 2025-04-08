import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(180),
          side: BorderSide(color: Color(0xff06D001)),
        ),
        shadows: [
          BoxShadow(
              color: Color(0xff024CAA),
              blurRadius: 50,
              offset: Offset(0, 1),
              spreadRadius: 25,
              blurStyle: BlurStyle.normal),
          BoxShadow(
              color: Color(0xff0D9276),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 2,
              blurStyle: BlurStyle.normal),
        ],
      ),
      child: CircleAvatar(
        radius: 40.r,
        backgroundColor: Color(0xff34A853),
        child: Icon(
          FontAwesomeIcons.check,
          color: Colors.white,
          size: 45.sp,
        ),
      ),
    );
  }
}

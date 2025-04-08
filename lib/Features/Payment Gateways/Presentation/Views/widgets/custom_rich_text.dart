import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichText extends StatelessWidget {
  final  String title;
  final  String value;
  const CustomRichText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
        children: [
          TextSpan(
              text: title,style: GoogleFonts.poppins(
              fontSize:20.sp,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
              color: Colors.white
          )
          ),
          TextSpan(
              text: value,style: GoogleFonts.inter(
              fontSize: 18.sp,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w400,
              color: Colors.white
          )
          ),
        ]
    ));
  }
}

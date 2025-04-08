import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPaymentSuccessMessage extends StatelessWidget {
  const CustomPaymentSuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 30),
      child: Text(
        'Payment Success',
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: Colors.white,
        )),
      ),
    );
  }
}

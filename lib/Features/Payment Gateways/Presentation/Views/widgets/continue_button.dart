import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/App colors manager/app_colors_manager.dart';

class ContinueButton extends StatelessWidget {
  final bool paymentMethodNone;
  final void Function()? onPressed;

  const ContinueButton(
      {super.key, required this.paymentMethodNone, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.7,
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            paymentMethodNone ? Colors.grey : null,
          ),
          foregroundColor:
              const WidgetStatePropertyAll(AppColorsManagers.customWhite),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          ),
        ),
        onPressed: onPressed,
        child: const Text('Continue'),
      ),
    );
  }
}

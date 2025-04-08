import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../Core/App colors manager/app_colors_manager.dart';
import '../../../Presentation/Views/screen/payment_gateways_screen.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 15.h),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              const WidgetStatePropertyAll(AppColorsManagers.customWhite),
          foregroundColor:
              const WidgetStatePropertyAll(AppColorsManagers.blueShadowHeader),
          overlayColor: const WidgetStatePropertyAll(Colors.grey),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
        ),
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const PaymentGatewaysScreen()),
            (_) => false),
        child: Text(
          'Go Back',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/App colors manager/app_colors_manager.dart';


class CartAppBarTitle extends StatelessWidget {
  const CartAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        'My Cart',
        style: GoogleFonts.firaCode(
          fontSize: 22.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.1,
          color: AppColorsManagers.customBlue,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

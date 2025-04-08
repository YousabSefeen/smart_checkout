import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/App colors manager/app_colors_manager.dart';
import 'checkout_button.dart';
import 'custom _image_widget.dart';
import 'custom_animation_widget.dart';

class PaymentMethodCard extends StatelessWidget {
  final String paymentMethodName;
  final Widget? subtitleWidget;
  final String logoPath;

  final String? groupValue;
  final bool isSelected;

  final void Function(String?)? onChanged;

  const PaymentMethodCard({
    super.key,
    required this.paymentMethodName,
    required this.subtitleWidget,
    required this.logoPath,
    required this.groupValue,
    required this.isSelected,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: CustomAnimationWidget(
        endPosition: isSelected ? 1.0 : 0.9,
        color: isSelected ? Colors.black87 : Colors.transparent,
        child: Card(
          elevation: 5,
          color: isSelected ? AppColorsManagers.customBlue : Colors.white,
          margin:    EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(color: Colors.grey),
          ),
          child: RadioListTile<String>(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            secondary: CustomImageWidget(image: logoPath),
            activeColor: Colors.white,
            splashRadius: 20,
            title: Text(paymentMethodName,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 15.sp,
                    color:isSelected? Colors.white: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ),
            subtitle: subtitleWidget,
            value: paymentMethodName,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

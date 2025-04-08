import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/Presentation/Views/widgets/payment_bottom_sheet.dart';


class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        child: ElevatedButton(
          onPressed: () => _showPaymentDialog(context),
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
            ),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            foregroundColor: const WidgetStatePropertyAll(Colors.black),
            overlayColor: const WidgetStatePropertyAll(Colors.grey),
          ),
          child: Text(
            'Checkout',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      // Allows tapping outside the modal to dismiss it
      barrierLabel: 'Dismiss',
      // Accessibility label for dismissing
      transitionDuration: const Duration(seconds: 7),
      // Animation duration
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PaymentBottomSheet(),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(
          ///********
          ///  Start Bottom To Top
          ///           begin: const Offset(0, 1),

          // Start from Right to Left
          begin: const Offset(1, 0),
          end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
    );
  }
}

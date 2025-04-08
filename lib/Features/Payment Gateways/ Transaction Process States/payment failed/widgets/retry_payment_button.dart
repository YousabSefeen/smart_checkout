import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/App navigator  manager/app_navigator.dart';

class RetryPaymentButton extends StatelessWidget {
  const RetryPaymentButton({super.key});

  final String retryPayment = 'Retry Payment';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => AppNavigator.redirectToPaymentGateways(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        retryPayment,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

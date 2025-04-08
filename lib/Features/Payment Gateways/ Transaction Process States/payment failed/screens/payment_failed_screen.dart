import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/Global Components/widgets/pop_scope_for_payment_gateways.dart';
import '../../../Paymob/ Transaction Process States/Presentation/View/Payment Failed/widgets/paymob_error_message.dart';
import '../widgets/error_indicator_avatar.dart';
import '../widgets/retry_payment_button.dart';
import '../widgets/use_a_different_card_button.dart';

class PaymentFailedScreen extends StatelessWidget {
  final String paymentMethod;
  final String? errorMessage;

  const PaymentFailedScreen({super.key,   this.errorMessage, required this.paymentMethod});

  final title = 'Oops! Invalid Card Number';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);

    return PopScopeForPaymentGateways(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: deviceSize.width * .9,
                child: Card(
                  elevation: 4,
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r),
                    top: Radius.circular(15.r),
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40.h),
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 18.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20.r)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 30.h),
                            paymentMethod == 'paymob'
                                ? const PaymobErrorMessage()
                                : _paymentErrorMessage(errorMessage!),
                            SizedBox(height: 25.h),
                            const RetryPaymentButton(),
                            SizedBox(height: 15.h),
                            const UseADifferentCardButton(),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -27,
                left: deviceSize.width * .36,
                child: const ErrorIndicatorAvatar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _paymentErrorMessage(String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        error,
        style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            height: 1.5),
        textAlign: TextAlign.center,
        //  text:  _buildHighlightedText(invalidCardMessage ,),
      ),
    );
  }
}

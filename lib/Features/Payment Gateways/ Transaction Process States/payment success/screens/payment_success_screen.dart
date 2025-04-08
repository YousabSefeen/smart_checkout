import 'package:flutter/material.dart';

import '../../../../../Core/Global Components/widgets/pop_scope_for_payment_gateways.dart';
import '../../../Paymob/ Transaction Process States/Presentation/View/payment success/widgets/paymob_success_transaction_data.dart';
import '../../../Stripe/Transaction Process States/View/payment success/Presentation/widgets/stripe_success_transaction_data.dart';
import '../../../paypal/Transaction Process States/data/models/paypal_payment_response_model.dart';
import '../../../paypal/Transaction Process States/presentation/widgets/paypal_success_transaction_data.dart';
import '../widgets/custom_dashed_line.dart';
import '../widgets/custom_half_circle.dart';
import '../widgets/custom_shadow_header.dart';

class PaymentSuccessScreen extends StatelessWidget {

  final String paymentMethod;
  final PaypalPaymentResponseModel? paymentResponseModel;
  const PaymentSuccessScreen({super.key, required this.paymentMethod,this.paymentResponseModel});

  @override
  Widget build(BuildContext context) {
    return PopScopeForPaymentGateways(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Transform.translate(
          offset: const Offset(0, -16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  left: 1,
                  right: 1,
                  child: CustomShadowHeader(),
                ),
                _getSuccessTransactionWidget(),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * .28,
                  left: MediaQuery.sizeOf(context).width * .02,
                  right: MediaQuery.sizeOf(context).width * .02,
                  child: const CustomDashedLine(),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * .26,
                  right: MediaQuery.sizeOf(context).width * .85,
                  child: const CustomHalfCircle(isLeftPosition: true),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * .26,
                  left: MediaQuery.sizeOf(context).width * .85,
                  child: const CustomHalfCircle(isLeftPosition: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StatelessWidget _getSuccessTransactionWidget() {
    if (paymentMethod == 'stripe') {
      return const StripeSuccessTransactionData();
    } else if (paymentMethod == 'paypal') {
      return   PaypalSuccessTransactionData(paymentResponseModel: paymentResponseModel!,);
    } else {
      return const PaymobSuccessTransactionData();
      ;
    }
  }
}

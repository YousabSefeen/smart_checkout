import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../../../ Transaction Process States/payment failed/screens/payment_failed_screen.dart';
import '../../../../ Transaction Process States/payment success/screens/payment_success_screen.dart';
import '../../../../../../Core/Global Components/widgets/pop_scope_for_payment_gateways.dart';

import '../../../../../../Core/animations/custom_animation_route.dart';

import '../../../../../../Core/payment_gateway_manager/paypal_payment/paypal_keys.dart';
import '../../../Transaction Process States/data/models/paypal_payment_response_model.dart';

class PaypalPaymentScreen extends StatelessWidget {
  const PaypalPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScopeForPaymentGateways(
      isMessageBack: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PaypalCheckoutView(
          sandboxMode: true,
          clientId: PaypalKeys.payPalClientID,
          secretKey: PaypalKeys.payPalSecret,
          transactions: [
            PaypalKeys.paypalPaymentTransactionModel,
          ],
          note: 'Contact us for any questions on your order.',
          onSuccess: (Map params) async {
            Navigator.of(context).pushAndRemoveUntil(
              CustomAnimationRoute(
                screen: PaymentSuccessScreen(
                  paymentMethod: 'paypal',
                  paymentResponseModel:
                      PaypalPaymentResponseModel.fromJson(params),
                ),
              ),
              (_) => false,
            );
          },
          onError: (error) {
            print("onError: $error");

            Navigator.of(context).pushAndRemoveUntil(
                CustomAnimationRoute(
                  screen: PaymentFailedScreen(
                    paymentMethod: 'paypal',
                    errorMessage: error,
                  ),
                ),
                (_) => false);
          },
          onCancel: () {
            if (kDebugMode) {
              print(
                  '*****************************cancelled*****************************:');
            }
          },
        ),
      ),
    );
  }
}

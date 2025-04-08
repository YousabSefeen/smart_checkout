import 'package:flutter/material.dart';
import '../../Features/Payment Gateways/Presentation/Views/screen/payment_gateways_screen.dart';
import '../animations/custom_animation_route.dart';

class AppNavigator {
  static redirectToPaymentGateways(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        CustomAnimationRoute(screen: const PaymentGatewaysScreen()),
        (_) => false);
  }
}

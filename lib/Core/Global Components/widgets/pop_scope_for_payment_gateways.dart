import 'package:flutter/material.dart';

import '../../../Features/Payment Gateways/Presentation/Views/screen/payment_gateways_screen.dart';
import '../../animations/custom_animation_route.dart';

class PopScopeForPaymentGateways extends StatelessWidget {
  final Widget child;
  final bool? isMessageBack;

  const PopScopeForPaymentGateways(
      {super.key, required this.child, this.isMessageBack});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pushAndRemoveUntil(
            CustomAnimationRoute(
                screen: PaymentGatewaysScreen(
                  messageBack: isMessageBack,
                ),
                isAddTaskScreen: true),
            (route) => false,
          );
        }
      },
      child: child,
    );
  }
}

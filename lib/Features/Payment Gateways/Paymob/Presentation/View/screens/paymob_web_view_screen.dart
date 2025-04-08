import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../ Transaction Process States/payment failed/screens/payment_failed_screen.dart';
import '../../../../ Transaction Process States/payment success/screens/payment_success_screen.dart';
import '../../../../../../Core/Global Components/widgets/pop_scope_for_payment_gateways.dart';
import '../../../../../../enums/web_view_status.dart';
import '../../Controller/paymob_web_view_provider.dart';

class PaymobWebViewScreen extends StatelessWidget {
  const PaymobWebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScopeForPaymentGateways(
      isMessageBack: true,
      child: Consumer<PaymobWebViewProvider>(
        builder: (context, paymobProvider, _) {
          handlePaymentStatus(context, paymobProvider.webViewStatus);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: WebViewWidget(
              key: const ValueKey('webview-instance'),
              controller: paymobProvider.webViewController,
            ),
          );
        },
      ),
    );
  }

  void handlePaymentStatus(BuildContext context, WebViewStatus status) {
    if (status == WebViewStatus.success) {
      _navigateToScreen(
          context, const PaymentSuccessScreen(paymentMethod: 'paymob'));
    } else if (status == WebViewStatus.error) {
      _navigateToScreen(
          context,
          const PaymentFailedScreen(
            paymentMethod: 'paymob',

          ));
    }
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Future.microtask(() {
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => screen),
          (_) => false,
        );
      }
    });
  }
}

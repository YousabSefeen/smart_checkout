import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../Core/Global Components/widgets/custom_loading_text.dart';
import '../../../../../../Core/Global Components/widgets/pop_scope_for_payment_gateways.dart';

import '../../../../../../Core/app strings manager/app_strings.dart';

import '../../../../../../Core/payment_gateway_manager/paymob_payment/paymob_keys.dart';
import '../../../Data/Models/order_details.dart';
import '../../Controller/paymob_payment_provider.dart';
import '../../Controller/paymob_web_view_provider.dart';
import 'paymob_web_view_screen.dart';

class PaymobInitializationScreen extends StatefulWidget {
  final String? phoneNumber;
  final String paymentMethod;

  const PaymobInitializationScreen({
    super.key,
    this.phoneNumber,
    required this.paymentMethod,
  });

  @override
  State<PaymobInitializationScreen> createState() =>
      _PaymobInitializationScreenState();
}

class _PaymobInitializationScreenState
    extends State<PaymobInitializationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _processPaymentAndNavigateToWebView();
      }
    });
  }

  Future<void> _processPaymentAndNavigateToWebView() async {
    if (!mounted) return; // ✅ التحقق قبل التنفيذ

    if (widget.paymentMethod == AppStrings.mobileWallets) {
      await Provider.of<PaymobPaymentProvider>(context, listen: false)
          .processMobileWalletPayment(
        phoneNumber: widget.phoneNumber!,
        orderDetails: OrderDetails(
          billingData: PaymobKeys.billingData,
          totalAmount: 11000 * 100,
          shippingData: PaymobKeys.shippingData,
          orderItems: PaymobKeys.orderItems,
        ),
      );
    } else {
      await Provider.of<PaymobPaymentProvider>(context, listen: false)
          .processVisaPayment(
        orderDetails: OrderDetails(
          billingData: PaymobKeys.billingData,
          totalAmount: 11000 * 100,
          shippingData: PaymobKeys.shippingData,
          orderItems: PaymobKeys.orderItems,
        ),
      );
    }

    if (mounted) {
      _setupAndNavigateToPaymobWebView(context);
    }
  }

  void _setupAndNavigateToPaymobWebView(BuildContext context) {
    if (!mounted) return; // ✅ منع تنفيذ الدالة إذا كان `unmounted`
    _initializePaymobWebView(context);
    _navigateToPaymobWebViewScreen(context);
  }

  void _initializePaymobWebView(BuildContext context) {
    if (!mounted) return;
    context.read<PaymobWebViewProvider>().initializeWebView(context);
  }

  void _navigateToPaymobWebViewScreen(BuildContext context) {
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const PaymobWebViewScreen(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScopeForPaymentGateways(
      isMessageBack: true,
      child: Scaffold(
        body: Center(
          child: Selector<PaymobPaymentProvider, String?>(
            selector: (context, provider) => provider.errorMessage,
            builder: (context, errorMessage, child) {
              _handlePaymentErrorMessageOne(errorMessage, context);
              return Center(
                child: errorMessage == null
                    ? const CustomLoadingText()
                    : Text('Error: $errorMessage'),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handlePaymentErrorMessageOne(
      String? errorMessage, BuildContext context) {
    if (errorMessage != null) {
      Future.delayed(const Duration(seconds: 1), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
            ),
          );
        }
      });
    }
  }
}

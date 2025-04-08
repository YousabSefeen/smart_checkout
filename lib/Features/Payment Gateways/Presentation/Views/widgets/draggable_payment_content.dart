import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/Presentation/Views/widgets/payment_method_app_bar.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/Presentation/Views/widgets/payment_method_list_view.dart';

import '../../../ Transaction Process States/payment failed/screens/payment_failed_screen.dart';
import '../../../ Transaction Process States/payment success/screens/payment_success_screen.dart';
import '../../../../../Core/App alerts manager/app_alerts_manager.dart';

import '../../../../../Core/animations/custom_animation_route.dart';
import '../../../../../Core/animations/smooth_entrance_widget.dart';
import '../../../../../Core/app strings manager/app_strings.dart';

import '../../../../../Core/payment_gateway_manager/stripe_payment/stripe_keys.dart';
import '../../../../../enums/payment_status.dart';
import '../../../Paymob/Presentation/View/screens/paymob_initialization_screen.dart';
import '../../../paypal/presentation/views/screens/paypal_payment_screen.dart';
import '../../../stripe/Presentation/Controller/stripe_payment_provider.dart';
import '../../Controller/payment_gateways_provider.dart';
import 'continue_button.dart';

class DraggablePaymentContent extends StatelessWidget {
  const DraggablePaymentContent({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.6,
      minChildSize: 0.32,
      expand: false,
      builder: (context, scrollController) {
        // This widget (SmoothEntranceWidget) was created manually to give a smooth effect while displaying the menu.
        return SmoothEntranceWidget(
          duration: const Duration(seconds: 14),
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.r),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h ),
              child: Consumer<PaymentGatewaysProvider>(
                builder: (context, selectedPaymentMethod, child) {
                  return Column(
                    children: [
                      const PaymentMethodAppBar(),
                      PaymentMethodListView(
                        scrollController: scrollController,
                        phoneNumberController: phoneNumberController,
                      ),
                      selectedPaymentMethod.isLoading
                          ? const CircularProgressIndicator()
                          : ContinueButton(
                              paymentMethodNone:
                                  selectedPaymentMethod.selectedPaymentMethod ==
                                      null,
                              onPressed: () => _handlePaymentSelection(
                                context: context,
                                paymentMethod:
                                    selectedPaymentMethod.selectedPaymentMethod,
                                phoneNumberController:
                                    phoneNumberController.text.trim(),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _handlePaymentSelection(
      {required BuildContext context,
      required String? paymentMethod,
      required String phoneNumberController}) async {
    if (paymentMethod == null) return;

    switch (paymentMethod) {
      case AppStrings.stripe:
        await _paymentByStripe(context);

        break;
      case AppStrings.payPal:
        _paymentByPaypal(context);
        break;
      case AppStrings.onlineCard:
        _paymentByCard(context: context);

        break;
      default:
        _paymentByPhoneNumber(
          context: context,
          phoneNumber: phoneNumberController,
        );
    }
  }

  void _navigateAndClearStack(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
      CustomAnimationRoute(screen: screen),
      (_) => false,
    );
  }

  void _paymentByCard({required BuildContext context}) =>
      _navigateAndClearStack(
        context,
        const PaymobInitializationScreen(paymentMethod: AppStrings.onlineCard),
      );

  void _paymentByPhoneNumber({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    if (phoneNumber.isEmpty) {
      AppAlerts.customErrorSnackBar(
          context: context, msg: AppStrings.enterPhoneNumberError);
    } else if (phoneNumber.length != 10) {
      AppAlerts.customErrorSnackBar(
          context: context, msg: AppStrings.invalidPhoneNumberError);
    } else {
      _navigateAndClearStack(
        context,
        PaymobInitializationScreen(
            paymentMethod: AppStrings.mobileWallets, phoneNumber: phoneNumber),
      );
    }
  }

  Future<void> _paymentByStripe(BuildContext context) async {
    context.read<PaymentGatewaysProvider>().updateLoadingState(true);
    final stripeProvider =
        Provider.of<StripePaymentProvider>(context, listen: false);

    await _processStripePayment(stripeProvider);

    if (!context.mounted) return;

    _handleStripePaymentResult(context, stripeProvider);

    context.read<PaymentGatewaysProvider>().updateLoadingState(false);
  }

  /// Execute the payment process via Stripe
  Future<void> _processStripePayment(
      StripePaymentProvider stripeProvider) async {
    await stripeProvider.stripePaymentProcess(
      paymentIntentModel: StripeKeys.paymentIntentModel,
      createUserModel: StripeKeys.createUserModel,
    );
  }

  /// Handle the Stripe payment result and display the error message if any
  void _handleStripePaymentResult(
      BuildContext context, StripePaymentProvider stripeProvider) {
    if (stripeProvider.stripeState == PaymentStates.success) {
      _handleStripePaymentSuccess(context);
    } else if (stripeProvider.stripeState == PaymentStates.error) {
      _handleStripePaymentFailure(stripeProvider, context);
    }
  }

  void _handleStripePaymentSuccess(BuildContext context) =>
      _navigateAndClearStack(
          context, const PaymentSuccessScreen(paymentMethod: 'stripe'));

  void _handleStripePaymentFailure(
      StripePaymentProvider stripeProvider, BuildContext context) {
    final error = 'The payment has been cancelled.';
    if (stripeProvider.stripeErrorMessage == error) {
      AppAlerts.customErrorSnackBar(context: context, msg: error);
    } else {
      _navigateAndClearStack(
          context,
          PaymentFailedScreen(
            paymentMethod: 'stripe',
            errorMessage: stripeProvider.stripeErrorMessage,
          ));
    }
  }

  _paymentByPaypal(BuildContext context) =>
      _navigateAndClearStack(context, const PaypalPaymentScreen());
}

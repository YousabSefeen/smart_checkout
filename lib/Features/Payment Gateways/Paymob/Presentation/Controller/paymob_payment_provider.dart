import 'package:flutter/material.dart';


import '../../../../../Core/payment_gateway_manager/paymob_payment/paymob_keys.dart';
import '../../Data/Models/order_details.dart';
import '../../Data/repository/paymob_repository.dart';

class PaymobPaymentProvider extends ChangeNotifier {
  final PaymobRepository paymobRepository;

  PaymobPaymentProvider({required this.paymobRepository});

  String? errorMessage;

  processMobileWalletPayment({
    required String phoneNumber,
    required OrderDetails orderDetails,
  }) async {
    final response = await paymobRepository.processMobileWalletPayment(
        phoneNumber: phoneNumber, orderDetails: orderDetails);
    response.fold((failure) {
      errorMessage = failure.toString();
      notifyListeners();
      print('failure: ${failure.toString()}');
    }, (redirectUrl) {
      PaymobKeys.mobileWalletRedirectUrl = redirectUrl;
      print('redirectUrl: ${redirectUrl}');
    });
  }

  processVisaPayment({
    required OrderDetails orderDetails,
  }) async {
    final response =
        await paymobRepository.processVisaPayment(orderDetails: orderDetails);
    response.fold((failure) {
      errorMessage = failure.toString();
      notifyListeners();
      print('failure: ${failure.toString()}');
    }, (iframeUrl) {
      PaymobKeys.paymentToken = iframeUrl;
      print('redirectUrl: ${iframeUrl}');
    });
  }
}

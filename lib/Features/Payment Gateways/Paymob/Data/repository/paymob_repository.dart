import 'package:dartz/dartz.dart';

import '../../../../../Core/Error/failure.dart';


import '../../../../../Core/payment_gateway_manager/paymob_payment/paymob_services.dart';
import '../Models/order_details.dart';
import 'base_paymob_repository.dart';

class PaymobRepository extends BasePaymobRepository {
  final PaymobServices paymobServices;

  PaymobRepository({required this.paymobServices});

  @override
  Future<Either<Failure, String>> processMobileWalletPayment(
      {required String phoneNumber, required OrderDetails orderDetails}) async {
    try {
      final redirectUrl = await paymobServices.processMobileWalletPayment(
          orderDetails: orderDetails, phoneNumber: phoneNumber);
      return right(redirectUrl);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, String>> processVisaPayment(
      {required OrderDetails orderDetails}) async {
    try {
      final iframeUrl =
          await paymobServices.processVisaPayment(orderDetails: orderDetails);
      return right(iframeUrl);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}

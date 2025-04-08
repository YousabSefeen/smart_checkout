import 'package:dartz/dartz.dart';

import '../../../../../Core/Error/failure.dart';
import '../Models/order_details.dart';

abstract class BasePaymobRepository {
  Future<Either<Failure, String>> processVisaPayment({
    required OrderDetails orderDetails,
  });

  Future<Either<Failure, String>> processMobileWalletPayment({
    required String phoneNumber,
    required OrderDetails orderDetails,
  });
}

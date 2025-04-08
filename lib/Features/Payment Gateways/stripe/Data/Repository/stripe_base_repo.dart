import 'package:dartz/dartz.dart';

import '../../../../../Core/Error/failure.dart';

import '../Models/create_user_model.dart';
import '../Models/payment_intent_model.dart';

abstract class StripeBaseRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentModel paymentIntentModel,
    required CreateUserModel createUserModel,
  });
}

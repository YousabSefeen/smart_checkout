import 'package:dartz/dartz.dart';

import 'package:smart_checkout/Features/Payment%20Gateways/stripe/Data/Repository/stripe_base_repo.dart';

import '../../../../../Core/Error/failure.dart';



import '../../../../../Core/payment_gateway_manager/stripe_payment/stripe_services.dart';
import '../Models/create_user_model.dart';
import '../Models/payment_intent_model.dart';

class StripeRepo extends StripeBaseRepo {
  final StripeServices stripeServices;

  StripeRepo({required this.stripeServices});

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentModel paymentIntentModel,
    required CreateUserModel createUserModel,
  }) async {
    try {
      await stripeServices.makePayment(
        paymentIntentModel: paymentIntentModel,
        createUserModel: createUserModel,
      );

      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}

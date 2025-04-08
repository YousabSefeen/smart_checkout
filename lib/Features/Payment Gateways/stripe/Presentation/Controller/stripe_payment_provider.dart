import 'package:flutter/material.dart';

import '../../../../../Core/Error/failure.dart';
import '../../../../../Core/Global Components/app_global_variables.dart';
import '../../../../../enums/payment_gateways.dart';
import '../../../../../enums/payment_status.dart';
import '../../Data/Models/create_user_model.dart';
import '../../Data/Models/payment_intent_model.dart';
import '../../Data/Repository/stripe_repo.dart';

class StripePaymentProvider extends ChangeNotifier {
  final StripeRepo stripeRepo;

  StripePaymentProvider({required this.stripeRepo});

  makeCardPayment() {
    GlobalVariables.initPaymentGateways = PaymentGateways.card;

    notifyListeners();
  }

  PaymentStates stripeState = PaymentStates.init;
  String? stripeErrorMessage;

  Future stripePaymentProcess({
    required PaymentIntentModel paymentIntentModel,
    required CreateUserModel createUserModel,
  }) async {
    print('stripeState: $stripeState');
    stripeState = PaymentStates.loading;
    print('stripeState: $stripeState');
    notifyListeners();
    final response = await stripeRepo.makePayment(
      paymentIntentModel: paymentIntentModel,
      createUserModel: createUserModel,
    );
    stripeState = PaymentStates.init;
    print('stripeState: $stripeState');
    notifyListeners();
    response.fold((Failure failure) {
      print('Error: ${failure.toString()}');
      stripeState = PaymentStates.error;

      stripeErrorMessage = failure.toString();

    }, (success) {
      stripeState = PaymentStates.success;

      return null;
    });
    print('stripeState: $stripeState');
    notifyListeners();
  }
}

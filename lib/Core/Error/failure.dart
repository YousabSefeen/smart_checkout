import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:smart_checkout/Core/Error/stripe_failure.dart';

import 'dio_failure.dart';

abstract class Failure {
  final Object catchError;

  Failure({required this.catchError});
}

class ServerFailure extends Failure {
  ServerFailure({required super.catchError});

  String get errorMessage {
    if (catchError is StripeException) {
      return StripeFailure(catchError: catchError).errorMessage;
    } else if (catchError is DioException) {
      return DioFailure(catchError: catchError).errorMessage;
    } else {
      return 'An unknown error occurred. Please try again later.${catchError.toString()}';
    }
  }

  @override
  String toString() {
    return errorMessage;
  }
}

import 'package:flutter_stripe/flutter_stripe.dart';

class StripeFailure {
  final Object catchError;

  StripeFailure({required this.catchError});

  String get errorMessage {
    if (catchError is StripeException) {
      final stripeError = catchError as StripeException;

      if (stripeError.error.code == FailureCode.Canceled) {
        return 'The payment has been cancelled.'; // رسالة مخصصة لهذا النوع من الأخطاء.
      }

      // لأي أخطاء أخرى:
      return 'Payment failed with error: ${stripeError.error.localizedMessage}';
    }

    // رسالة عامة في حال كان الخطأ من نوع غير متوقع.
    return 'An unexpected error occurred: ${catchError.toString()}';
  }

  @override
  String toString() {
    return errorMessage;
  }
}

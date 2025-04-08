import '../../generated/assets.dart';

class AppStrings {
  static const String stripe = 'Stripe';
  static const String stripeSub = 'Visa - MasterCard - American Express';
  static const String payPal = 'PayPal';
  static const String onlineCard = 'Online Card';
  static const String onlineCardSub = 'Visa - MasterCard - Meeza';
  static const String mobileWallets = 'Mobile Wallets';

  static const String enterPhoneNumberError = 'Please enter your phone number';

  static const String invalidPhoneNumberError = 'Invalid phone number';

  static final List<PaymentMethod> paymentOptions = [
    PaymentMethod(
      name: onlineCard,
      subtitle: 'Visa - MasterCard - Meeza',
      logo: Assets.imagesOnlineCard,
    ),
    PaymentMethod(
        name: mobileWallets,
        subtitle: '',
        logo: Assets.imagesMobileWalletsLogo),
    PaymentMethod(
        name: stripe,
        subtitle: 'Visa - MasterCard - American Express',
        logo: Assets.imagesStripe),
    PaymentMethod(name: payPal, subtitle: '', logo: Assets.imagesPayPal),
  ];

  static String messageBack =
      'You have canceled the payment, and the transaction was not completed.';
}

class PaymentMethod {
  final String name;
  final String subtitle;
  final String logo;

  PaymentMethod(
      {required this.name, required this.subtitle, required this.logo});
}

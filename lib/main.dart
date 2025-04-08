import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:provider/provider.dart';


import 'Core/Themes/app_light_mode.dart';
import 'Core/Utils/server_locator.dart';

import 'Core/payment_gateway_manager/stripe_payment/stripe_keys.dart';
import 'Features/Payment Gateways/Paymob/Presentation/Controller/paymob_payment_provider.dart';
import 'Features/Payment Gateways/Paymob/Presentation/Controller/paymob_web_view_provider.dart';
import 'Features/Payment Gateways/Presentation/Controller/payment_gateways_provider.dart';
import 'Features/Payment Gateways/Presentation/Views/screen/payment_gateways_screen.dart';
import 'Features/Payment Gateways/stripe/Data/Repository/stripe_repo.dart';
import 'Features/Payment Gateways/stripe/Presentation/Controller/stripe_payment_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ServicesLocator().init();
  Stripe.publishableKey = StripeKeys.publishableKey;

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<StripePaymentProvider>(
        create: (_) => StripePaymentProvider(stripeRepo: sl<StripeRepo>()),
      ),


      ChangeNotifierProvider<PaymentGatewaysProvider>(
        create: (_) => PaymentGatewaysProvider(),
      ),

      ChangeNotifierProvider<PaymobPaymentProvider>(
        create: (_) => PaymobPaymentProvider(
          paymobRepository: sl(),
        ),
      ),
      ChangeNotifierProvider<PaymobWebViewProvider>(
        create: (_) => PaymobWebViewProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Payment Gateway',
          themeMode: ThemeMode.light,
          theme: AppLightModel.mode,
          home: const PaymentGatewaysScreen(),
        );
      },

    );
  }
}




import 'package:get_it/get_it.dart';


import '../../Features/Payment Gateways/Paymob/Data/repository/paymob_repository.dart';
import '../../Features/Payment Gateways/Paymob/Presentation/Controller/paymob_payment_provider.dart';
import '../../Features/Payment Gateways/stripe/Data/Repository/stripe_repo.dart';
import '../../Features/Payment Gateways/stripe/Presentation/Controller/stripe_payment_provider.dart';



import '../payment_gateway_manager/paymob_payment/paymob_services.dart';
import '../payment_gateway_manager/stripe_payment/stripe_services.dart';
import 'api_services.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// تسجيل الخدمات الأساسية
    sl.registerLazySingleton<ApiServices>(() => ApiServices());

    /// خدمات الدفع Paymob
    sl.registerLazySingleton<PaymobServices>(
        () => PaymobServices(apiServices: sl()));
    sl.registerLazySingleton<PaymobRepository>(
        () => PaymobRepository(paymobServices: sl()));

    /// مزود الحالة Paymob
    sl.registerFactory(() => PaymobPaymentProvider(paymobRepository: sl()));

    /// خدمات الدفع stripe
    sl.registerLazySingleton<StripeServices>(
        () => StripeServices(apiServices: sl()));
    sl.registerLazySingleton<StripeRepo>(
        () => StripeRepo(stripeServices: sl()));

    /// مزود الحالة stripe
    sl.registerFactory(() => StripePaymentProvider(stripeRepo: sl()));
  }
}

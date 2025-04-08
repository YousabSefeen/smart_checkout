// import 'package:flutter/material.dart';
// import 'package:payment_gateway/Features/Payment%20Gateways/%20Transaction%20Process%20States/payment%20success/screens/payment_success_screen.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../ Transaction Process States/payment failed/screens/payment_failed_screen.dart';
// import '../../../../../../Core/animations/custom_animation_route.dart';
// import '../../../../../../app_global_variables.dart';
// import '../../../../../../enums/payment_status.dart';
// import '../../../../Presentation/Views/screen/payment_gateways_screen.dart';
// import '../../../Data/Models/create_user_model.dart';
// import '../../../Data/Models/payment_intent_model.dart';
// import '../../Controller/stripe_payment_provider.dart';
//
// class StripeScreen extends StatefulWidget {
//   const StripeScreen({super.key});
//
//   @override
//   State<StripeScreen> createState() => _StripeScreenState();
// }
//
// class _StripeScreenState extends State<StripeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _processStripePayment();
//   }
//   bool isLoading=false;
//   _processStripePayment() async {
//     setState(() {
//       isLoading=true;
//     });
//     await Provider.of<StripePaymentProvider>(context, listen: false)
//         .stripePaymentProcess(
//       paymentIntentModel: PaymentIntentModel(
//           currency: 'USD', amount: 100, customerId: GlobalVariables.customerID),
//
//       //TODO the "createUserModel:"
//       //      This Model is filled from the user's database when he subscribes to the application for the first time.
//       createUserModel: CreateUserModel(
//         name: 'Yousab 55',
//         email: 'yousabsefeen55@gmail.com',
//         phone: '01227155559',
//       ),
//     );
//     setState(() {
//       isLoading=false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<StripePaymentProvider >(
//
//         builder: (context, provider, child) {
//
//
//           if (provider.stripeState == PaymentStates.success) {
//             Future.microtask(() {
//               if (context.mounted) {
//                 Navigator.of(context).pushAndRemoveUntil(
//                     CustomAnimationRoute(
//                       screen:
//                           const PaymentSuccessScreen(paymentMethod: 'stripe'),
//                     ),
//                     (_) => false);
//               }
//             });
//           } else if (provider.stripeState == PaymentStates.error) {
//         anErrorOccurred(
//             context: context,
//             errorMessage:
//                 provider.stripeErrorMessage ?? 'Stripe Error Message');
//       }
//       return  SizedBox();
//     });
//   }
//
//   void anErrorOccurred(
//       {required BuildContext context, required String errorMessage}) {
//     final error='The payment has been cancelled.';
//          Future.microtask(() {
//       if (context.mounted) {
//
//         Navigator.of(context).pushAndRemoveUntil(
//             CustomAnimationRoute(
//               screen:errorMessage==error?
//
//               const PaymentGatewaysScreen(  messageBack: true,):
//                PaymentFailedScreen( paymentMethod: 'stripe', errorMessage:errorMessage,),
//
//
//             ),
//                 (_) => false);
//
//       }
//     });
//
//   }
// }

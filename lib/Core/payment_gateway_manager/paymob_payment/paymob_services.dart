import 'package:dio/dio.dart';
import 'package:smart_checkout/Core/payment_gateway_manager/paymob_payment/paymob_keys.dart';



import '../../../Features/Payment Gateways/Paymob/Data/Models/order_details.dart';
import '../../../Features/Payment Gateways/Paymob/Data/Models/paymob_order_request_model.dart';
import '../../Utils/api_services.dart';
import '../../app strings manager/app_strings.dart';
import '../payment_gateway_manager.dart';

class PaymobServices {
  final ApiServices apiServices;

  PaymobServices({required this.apiServices});

  final Options _defaultOptions =
      Options(headers: {'Content-Type': 'application/json'});

  Future<String> _fetchAuthToken() async {
    final Response response = await apiServices.post(
      url: PaymobKeys.fetchAuthTokenUrl,
      options: _defaultOptions,
      data: {'api_key': PaymobKeys.aPIKey},
    );

    final token = response.data?['token']?.toString();
    if (token == null) {
      throw Exception('Invalid response:Missing Fetch Auth Token');
    }
    return token;
  }

  Future<String> _fetchOrderId(
      {required String token, required OrderDetails orderDetails}) async {
    final Response response = await apiServices.post(
      url: PaymobKeys.orderCreationUrl,
      options: _defaultOptions,
      data: PaymobOrderRequestModel(
        authToken: token,
        apiSource: 'INVOICE',
        totalPrice: orderDetails.totalAmount,
        // 110 جنيه
        currency: 'EGP',
        shippingData: orderDetails.shippingData,
        integrations: [PaymobKeys.integrationOnlineCardId],
        items: orderDetails.orderItems,
        deliveryNeeded: false,
      ).toJson(),
    );

    final orderId = response.data?['id']?.toString();

    if (orderId == null) {
      throw Exception('Invalid response:Missing order ID');
    }

    return orderId;
  }

  Future _fetchPaymentRequest(
      {required String authToken,
      required String orderId,
      required OrderDetails orderDetails}) async {
    final requestData = {
      'auth_token': authToken,
      'amount_cents': orderDetails.totalAmount, // إجمالي الطلب = 110 جنيه
      'billing_data': orderDetails.billingData!.toJson(),
      'order_id': orderId,
      'integration_id': PaymentGatewayManager.selectedPaymentMethod ==
              AppStrings.mobileWallets
          ? PaymobKeys.integrationMobileWalletId.toString()
          : PaymobKeys.integrationOnlineCardId.toString(),
      'expiration': 3600,

      'currency': 'EGP',

      'lock_order_when_paid': 'false',
    };

    final response = await apiServices.post(
      url: PaymobKeys.fetchPaymentRequestUrl,
      options: _defaultOptions,
      data: requestData,
    );

    final finalToken = response.data?['token'];

    if (finalToken == null) {
      throw Exception('Invalid response:Missing fetch Payment Request');
    }

    return finalToken;
  }

  Future _processMobileWalletPayment(
      {required String phoneNumber, required String paymentToken}) async {
    final paymentData = {
      'source': {
        'identifier': phoneNumber,
        'subtype': 'WALLET',
      },
      'payment_token': paymentToken,
    };

    final response = await apiServices.post(
      url: PaymobKeys.walletPaymentUrl,
      options: _defaultOptions,
      data: paymentData,
    );

    final redirectUrl = response.data?['redirect_url']?.toString();

    if (redirectUrl == null) {
      throw Exception(
          'Invalid response:Missing  Redirect URL in mobile wallets');
    }

    return redirectUrl;
  }

  Future<String> _fitchPaymentToken(
      {required OrderDetails orderDetails}) async {
    final String token = await _fetchAuthToken();

    final orderId =
        await _fetchOrderId(token: token, orderDetails: orderDetails);

    final paymentToken = await _fetchPaymentRequest(
        authToken: token, orderId: orderId, orderDetails: orderDetails);

    return paymentToken;
  }

  Future<String> processVisaPayment(
      {required OrderDetails orderDetails}) async {
    final paymentToken = await _fitchPaymentToken(orderDetails: orderDetails);
    return paymentToken;
  }

  Future<String> processMobileWalletPayment(
      {required OrderDetails orderDetails, required String phoneNumber}) async {
    final paymentToken = await _fitchPaymentToken(orderDetails: orderDetails);
    final redirectUrl = await _processMobileWalletPayment(
        phoneNumber: phoneNumber, paymentToken: paymentToken);

    return redirectUrl;
  }
}

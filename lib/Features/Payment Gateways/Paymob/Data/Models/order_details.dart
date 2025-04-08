

import 'package:smart_checkout/Features/Payment%20Gateways/Paymob/Data/Models/paymob_billing_data_model.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/Paymob/Data/Models/paymob_order_request_model.dart';

class OrderDetails {
  final double totalAmount;
  final ShippingData shippingData;
  final List<OrderItem> orderItems;
  final PaymobBillingDataModel? billingData;

  OrderDetails({
    required this.totalAmount,
    required this.shippingData,
    required this.orderItems,
    this.billingData,
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/payment_gateways_provider.dart';
import 'checkout_button.dart';
import 'custom_rich_text.dart';

class CartFooterBar extends StatelessWidget {
  const CartFooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
              title: 'Items: ',
              value: '${context.watch<PaymentGatewaysProvider>().items.length}',
            ),
            CustomRichText(
              title: 'Total: ',
              value:
                  '${context.watch<PaymentGatewaysProvider>().getTotalCartPrice()} EGP',
            ),
          ],
        ),
        const SizedBox(width: 20),
        const CheckoutButton(),
      ],
    );
  }
}

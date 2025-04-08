import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/Presentation/Views/widgets/payment_method_card.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/Presentation/Views/widgets/subtitle_widget.dart';

import '../../../../../Core/app strings manager/app_strings.dart';
import '../../Controller/payment_gateways_provider.dart';



class PaymentMethodListView extends StatelessWidget {

 final ScrollController scrollController;

 final TextEditingController phoneNumberController;


  const PaymentMethodListView({super.key, required this.scrollController,  required this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return Selector<PaymentGatewaysProvider, String?>(
      selector: (context, provider) => provider.selectedPaymentMethod,
      builder: (context, selectedPaymentMethod, child) => Expanded(
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            controller: scrollController,
            itemCount: AppStrings.paymentOptions.length,
            itemBuilder: (BuildContext context, int index) {
              final PaymentMethod paymentData =
                  AppStrings.paymentOptions[index];
              return PaymentMethodCard(
                paymentMethodName: paymentData.name,
                subtitleWidget: SubtitleWidget(
                  index: index,
                  isPaymentSelected: selectedPaymentMethod == paymentData.name,
                  phoneNumberController: phoneNumberController,
                ),
                logoPath: paymentData.logo,
                isSelected: selectedPaymentMethod == paymentData.name,
                groupValue: selectedPaymentMethod,
                onChanged: (String? newValue) {
                  context
                      .read<PaymentGatewaysProvider>()
                      .selectPaymentMethod(paymentData.name);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

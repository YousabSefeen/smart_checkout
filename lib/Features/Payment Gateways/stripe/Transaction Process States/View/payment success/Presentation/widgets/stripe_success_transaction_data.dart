import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_checkout/Features/Payment%20Gateways/stripe/Transaction%20Process%20States/View/payment%20success/Presentation/widgets/stripe_payment_method_info.dart';

import '../../../../../../ Transaction Process States/payment success/widgets/custom_back_button.dart';
import '../../../../../../ Transaction Process States/payment success/widgets/custom_check_icon.dart';
import '../../../../../../ Transaction Process States/payment success/widgets/custom_payment_success_message.dart';
import '../../../../../../ Transaction Process States/payment success/widgets/order_success_info.dart';
import '../../../../../../../../Core/App colors manager/app_colors_manager.dart';

class StripeSuccessTransactionData extends StatelessWidget {
  const StripeSuccessTransactionData({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColorsManagers.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: const BorderSide(color: AppColorsManagers.customBlue)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 22, right: 22),
            child: Column(
              children: [
                SizedBox(
                  // Sets the height to 31% of the device height (deviceHeight * 0.31)
                  // to ensure proper alignment with the Custom Half Circle and Custom Dash Line
                  // in the Thank You screen.
                  height: deviceHeight * .32,
                  child: Column(
                    children: [
                      SizedBox(height: deviceHeight * 0.03),
                      const CustomCheckIcon(),
                      const CustomPaymentSuccessMessage(),
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.33,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const OrderSuccessInfo(
                            title: 'Order ID', sub: '5555555'),
                        const SizedBox(height: 20),
                        OrderSuccessInfo(
                          title: 'Date',
                          sub: _dateNow(),
                        ),
                        const SizedBox(height: 20),
                        OrderSuccessInfo(
                          title: 'Time',
                          sub: _timeNow(),
                        ),
                        const SizedBox(height: 20),
                        //  const OrderInfoItem(title: 'To', sub: 'Sam Louis'),
                        const OrderSuccessInfo(
                            title: 'Payment Method', sub: ''),
                        const SizedBox(height: 20),
                        const StripePaymentMethodInfo(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(left: 22, right: 22),
            decoration: BoxDecoration(
              color: AppColorsManagers.blueShadowHeader,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: 75,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                const Column(
                  children: [
                    OrderSuccessInfo(title: 'Total', sub: '110000.0 EGP'),
                    SizedBox(height: 20),
                    CustomBackButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _dateNow() {
    final date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return date;
  }

  String _timeNow() {
    final date = DateFormat('h:mm a').format(DateTime.now());
    return date;
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../Core/App alerts manager/app_alerts_manager.dart';
import '../../../../../Core/App colors manager/app_colors_manager.dart';
import '../../Controller/payment_gateways_provider.dart';
import '../widgets/cart_footer_bar.dart';
import '../widgets/cart_item_list_view.dart';

class PaymentGatewaysScreen extends StatefulWidget {
  final bool? messageBack;

  const PaymentGatewaysScreen({super.key, this.messageBack});

  @override
  State<PaymentGatewaysScreen> createState() => _PaymentGatewaysScreenState();
}

class _PaymentGatewaysScreenState extends State<PaymentGatewaysScreen> {
  @override
  void initState() {
    super.initState();
    _removeSelectedPaymentMethod();
    displayMessageBack();
  }

  void _removeSelectedPaymentMethod() => Future.microtask(() {
        if (mounted) {
          Provider.of<PaymentGatewaysProvider>(context, listen: false)
              .removeSelectedPaymentMethod();
        }
      });

  displayMessageBack(){
    if(widget.messageBack==true){
     Future.delayed(const Duration(seconds: 1),() {
       if( mounted){
         return AppAlerts.customDialog(context: context );
       }
     });
    }

  }

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print('object');
    final deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xffF7FBFC),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: deviceHeight * 0.13, top: 10, right: 10),
              child: CartItemListView(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: deviceHeight * 0.13,
                decoration: const BoxDecoration(
                  color: AppColorsManagers.customBlue,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 7),
                  child: CartFooterBar(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../Core/App alerts manager/app_alerts_manager.dart';
import '../../Controller/payment_gateways_provider.dart';
import '../../models/cart_item_model.dart';
import 'cart_app_bar_title.dart';
import 'cart_item_card.dart';



class CartItemListView extends StatelessWidget {
    CartItemListView({super.key});
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentGatewaysProvider>(
      builder: (context, provider, _) => Scrollbar(
      controller: scrollController,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
        itemCount: provider.items.length,
        itemBuilder: (context, index) {
            final newIndex = index; // تعويضًا عن الـ Container الأسود
            final product = provider.items[newIndex];
            final isEndProduct = provider.items.last == product;

            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 8, bottom: 10),
              child: Column(
                children: [
                  index == 0 ? const CartAppBarTitle() : const SizedBox(),
                  CartItemCard(
                    isEndProduct: isEndProduct,
                    image: product.image,
                    name: product.name,
                    description: product.description,
                    price: product.price,
                    quantity: product.quantity,
                    onDeleteProduct: () =>
                        _deleteProduct(context, product, newIndex),
                    onIncreaseQuantity: () =>
                        _increaseItemQuantity(context, product),
                    onDecreaseQuantity: () =>
                        _decreaseItemQuantity(context, product),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _increaseItemQuantity(BuildContext context, CartItemModel product) {
    AppAlerts.customToast(isIncreaseButton: true);
    return context
        .read<PaymentGatewaysProvider>()
        .increaseItemQuantity(product.id);
  }
    void _decreaseItemQuantity(BuildContext context, CartItemModel product) {
      if(product.quantity==1){
        AppAlerts.customErrorSnackBar(context: context, msg: ' Quantity can\'t be zero. Please select at least one item.');
      }else{
        AppAlerts.customToast(isIncreaseButton: false);
        context
            .read<PaymentGatewaysProvider>()
            .decreaseItemQuantity(product.id);
      }
    }
  void _deleteProduct(BuildContext context, CartItemModel product, int index) {
    context.read<PaymentGatewaysProvider>().removeItem(product.id);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Item removed from cart. Tap "Undo" to restore it.'),
      action: SnackBarAction(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          label: 'Undo',
          onPressed: () {
            context
                .read<PaymentGatewaysProvider>()
                .undoRemoveItem(product: product, index: index);
          }),
    ));
  }


}

import 'package:flutter/material.dart';


import '../../../../Core/payment_gateway_manager/payment_gateway_manager.dart';
import '../../../../generated/assets.dart';
import '../models/cart_item_model.dart';

class PaymentGatewaysProvider extends ChangeNotifier {
  String? selectedPaymentMethod;

  void selectPaymentMethod(String paymentName) {
    selectedPaymentMethod = paymentName;
    PaymentGatewayManager.selectedPaymentMethod = selectedPaymentMethod;
    notifyListeners();
  }
 void removeSelectedPaymentMethod(){
    selectedPaymentMethod=null;
    notifyListeners();
 }
  bool isLoading=false;

 void updateLoadingState(bool loading){

    isLoading=loading;
    notifyListeners();
  }

  final List<CartItemModel> items=[

    CartItemModel(id: '1', name: 'Apple Watch Series 9', description: 'Retina display, waterproof, heart rate tracking' , image: Assets.imagesAppleWatch, quantity: 1, price: 399),
    CartItemModel(id: '2', name: 'Nike Air Max 270', description: 'Comfortable, lightweight, perfect for running', image: Assets.imagesNikeAirMax, quantity:1, price: 150),
    CartItemModel(id: '3', name: 'Sony WH-1000XM5', description: 'Noise cancelling, Hi-res audio, 30h battery', image:Assets.imagesSonyHeadphone ,quantity: 1, price: 349),

    CartItemModel(id: '4', name: 'MacBook Air M2', description: '13.6-inch Retina display, 8GB RAM, 256GB SSD' , image: Assets.imagesMacBook, quantity: 1, price: 999),
    CartItemModel(id: '5', name: 'Samsung Galaxy Buds 2', description: 'Active noise cancellation, long battery life', image: Assets.imagesSamsungBuds, quantity:1, price: 120),
    CartItemModel(id: '6', name: 'Logitech MX Master 3S', description: 'Ergonomic design, ultra-fast scrolling, quiet clicks', image:Assets.imagesLogitechMouse ,quantity: 1, price:99),

  ];

  double getTotalCartPrice() {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }
  void increaseItemQuantity(String id) {
    final index = items.indexWhere((item) => item.id == id);

    if (index != -1) {
      items[index].quantity += 1;

    } else {
      print('Item not found');
    }

    notifyListeners();
  }

  void decreaseItemQuantity(String id) {
    final index = items.indexWhere((item) => item.id == id);

    if (index != -1) {
      items[index].quantity -= 1;

    } else {
      print('Item not found');
    }


    notifyListeners();
  }

  void removeItem(String id) {
    final index = items.indexWhere((item) => item.id == id);
      items.removeAt(index);


    notifyListeners();

  }

  void undoRemoveItem({required CartItemModel product, required int index}) {
    items.insert(index, product);
    notifyListeners();
  }
}


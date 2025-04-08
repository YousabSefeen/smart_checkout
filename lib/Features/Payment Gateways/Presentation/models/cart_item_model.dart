

class CartItemModel {
  final String id;
  final String name;

  final String description;
  final String image;
    int quantity;
    int price;

  CartItemModel({required this.id, required this.name, required this.description,  required this.image,required this.quantity, required this.price});
}
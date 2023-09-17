import 'package:buy_right/models/product.dart';

class CartProduct {
  Product product;
  int quantity;

  CartProduct({
    required this.product,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : Product(
              id: 'id',
              name: 'Unknown',
              description: '...',
              images: ['https://images.unsplash.com/photo-1501967111356-35219aeb2ea1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHdhcm5pbmd8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'],
              price: 0,
              quantity: 0,
              category: 'All',
            ),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> toJsonWithOnlyId() {
    return {
      'product': product.id,
      'quantity': quantity,
    };
  }
}

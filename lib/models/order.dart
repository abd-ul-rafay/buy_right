import 'cart_product.dart';

class Order {
  String id;
  String user;
  List<CartProduct> products;
  double totalPrice;
  String address;
  int status;
  DateTime createdAt;

  Order({
    required this.id,
    required this.user,
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      products: json['products'] != null
          ? (json['products'] as List)
              .map((cp) => CartProduct.fromJson(cp))
              .toList()
          : [],
      totalPrice: json['totalPrice'] != null
          ? (json['totalPrice'] is int
              ? (json['totalPrice'] as int).toDouble()
              : json['totalPrice'] as double)
          : 0.0,
      address: json['address'] ?? '',
      status: json['status'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'products': products,
      'totalPrice': totalPrice,
      'address': address,
      'status': status,
      'createdAt': createdAt,
    };
  }
}

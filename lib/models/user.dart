import '../utils/constants.dart';

class User {
  String id;
  String token;
  String name;
  String email;
  String type;
  String address;
  List<String> cart;

  User({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.type,
    required this.address,
    required this.cart,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      token: json['token'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      type: json['type'] ?? CUSTOMER,
      address: json['address'] ?? '',
      cart: json['cart'] != null && json['cart'] is List
          ? (json['cart'] as List<dynamic>)
              .map((p) => p['product'].toString())
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'token': token,
      'name': name,
      'email': email,
      'type': type,
      'address': address,
      'cart': cart,
    };
  }

  User copyWith({
    String? id,
    String? token,
    String? name,
    String? email,
    String? type,
    String? address,
    List<String>? cart,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      type: type ?? this.type,
      address: address ?? this.address,
      cart: cart ?? this.cart,
    );
  }
}

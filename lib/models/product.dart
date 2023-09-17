class Product {
  String id;
  String name;
  String description;
  List<String> images;
  double price;
  int quantity;
  String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.quantity,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: json['images'] != null && json['images'] is List
          ? (json['images'] as List<dynamic>)
              .map((image) => image.toString())
              .toList()
          : <String>[],
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? 'All',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'images': images,
      'price': price,
      'quantity': quantity,
      'category': category,
    };
  }
}

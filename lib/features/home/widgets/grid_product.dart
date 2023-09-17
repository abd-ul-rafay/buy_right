import 'package:buy_right/common/product_image.dart';
import 'package:flutter/material.dart';

class GridProduct extends StatelessWidget {
  final String name;
  final double price;
  final String imagePath;

  const GridProduct({
    Key? key,
    required this.name,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImage(
          imagePath: imagePath,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16.0,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}

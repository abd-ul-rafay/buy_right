import 'package:flutter/material.dart';

class AboutProduct extends StatelessWidget {
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String description;

  const AboutProduct({
    Key? key,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '"$name"',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(category),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: quantity > 0 ? 'In stock,\n' : 'Out of stock,\n',
                style: TextStyle(
                  color: quantity > 0 ?  Colors.green : Colors.red,
                ),
                children: [
                  const TextSpan(
                    text: 'Quantity: ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '$quantity',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Price'),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(description),
      ],
    );
  }
}

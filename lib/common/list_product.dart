import 'package:buy_right/models/product.dart';
import 'package:flutter/material.dart';
import 'product_image.dart';

class ListProduct extends StatelessWidget {
  final Product product;
  final int quantity;
  final double spacing;

  const ListProduct({
    Key? key,
    required this.product,
    required this.quantity,
    required this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spacing),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 75.0,
              child: ProductImage(imagePath: product.images.first),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180.0,
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)} x $quantity = \$${(product.price * quantity).toStringAsFixed(2)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:buy_right/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/product_image.dart';
import 'custom_icon_btn.dart';

class ListProduct extends StatelessWidget {
  final Product product;
  final int quantity;
  final void Function(int) handleIconClick;
  const ListProduct({Key? key, required this.product, required this.quantity, required this.handleIconClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
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
              height: 120.0,
              child: ProductImage(imagePath: product.images.first),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.55,
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
                  height: 10.0,
                ),
                Text('\$${product.price.toStringAsFixed(2)}',),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: size.width * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomIconBtn(
                            icon: Icon(
                              Icons.add,
                              color: Colors.grey.shade700,
                              size: 15.0,
                            ),
                            onPressed: () => handleIconClick(quantity + 1),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(quantity.toString()),
                          const SizedBox(
                            width: 10.0,
                          ),
                          CustomIconBtn(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.grey.shade700,
                              size: 15.0,
                            ),
                            onPressed: () => handleIconClick(quantity - 1),
                          ),
                        ],
                      ),
                      CustomIconBtn(
                        icon: SvgPicture.asset(
                          'assets/icons/delete.svg',
                          color: Colors.grey.shade700,
                        ),
                        onPressed: () => handleIconClick(0),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

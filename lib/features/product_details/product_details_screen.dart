import 'package:buy_right/common/custom_button.dart';
import 'package:buy_right/features/product_details/widgets/about_product.dart';
import 'package:buy_right/features/product_details/widgets/images_container.dart';
import 'package:buy_right/features/product_details/widgets/quantity_slider.dart';
import 'package:buy_right/models/product.dart';
import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../common/icon_container.dart';
import '../../utils/constants.dart';
import '../cart/cart_services.dart';
import 'product_details_services.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isLoading = false;
  bool _isDeleteLoading = false;
  int _sliderValue = 1;

  void deleteProduct() async {
    setState(() {
      _isDeleteLoading = true;
    });
    await ProductDetailsServices.deleteProduct(
        widget.product.id, context, mounted);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void handleAddButton() async {
    setState(() {
      _isLoading = true;
    });
    await CartServices.manageCart(
      widget.product.id,
      _sliderValue,
      context,
      mounted,
      isFirstTime: true,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImagesContainer(
                    height: size.height * 0.55,
                    images: widget.product.images,
                  ),
                  Positioned(
                    top: 15.0,
                    left: 15.0,
                    child: SafeArea(
                      child: IconContainer(
                        icon: SvgPicture.asset(
                          'assets/icons/back_arrow.svg',
                          color: Colors.grey.shade500,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AboutProduct(
                      name: widget.product.name,
                      category: widget.product.category,
                      quantity: widget.product.quantity,
                      price: widget.product.price,
                      description: widget.product.description,
                    ),
                    Visibility(
                      // only show cart button if it's customer
                      visible: Provider.of<UserProvider>(context).user.type ==
                          CUSTOMER,
                      replacement: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomButton(
                            onPressed: deleteProduct,
                            text: 'Delete Product',
                            isLoading: _isDeleteLoading,
                            loadingText: 'Deleting Product...',
                          ),
                        ],
                      ),
                      child: Visibility(
                        visible: widget.product.quantity > 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text('Select quantity'),
                            QuantitySlider(
                              quantity: widget.product.quantity,
                              sliderValue: _sliderValue.toInt(),
                              setSliderValue: (value) => setState(() {
                                _sliderValue = value.toInt();
                              }),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomButton(
                              onPressed: handleAddButton,
                              text: 'Add to Cart',
                              isLoading: _isLoading,
                              loadingText: 'Adding to Cart...',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

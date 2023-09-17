import 'package:buy_right/common/custom_button.dart';
import 'package:buy_right/common/icon_container.dart';
import 'package:buy_right/features/cart/cart_services.dart';
import 'package:buy_right/features/cart/widgets/list_product.dart';
import 'package:buy_right/features/checkout/checkout_screen.dart';
import 'package:buy_right/models/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../home/widgets/payment_loading.dart';
import 'widgets/loading_item.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback afterPlacingOrder;
  const CartScreen({Key? key, required this.afterPlacingOrder}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartProduct> _cartProducts = [];
  bool _isLoading = true;

  void handleCheckoutBtn() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(
          cartProducts: _cartProducts,
          total: calculatePayment(),
        ),
      ),
    )
        .then((value) {
      // after order is placed, navigate to orders screen
      widget.afterPlacingOrder();
    });
  }

  void updateCart(int index, int quantity) {
    if (quantity < 0 || quantity > _cartProducts[index].product.quantity) {
      return;
    }

    CartServices.manageCart(
      _cartProducts[index].product.id,
      quantity,
      context,
      mounted,
    );

    if (quantity == 0) {
      _cartProducts.removeAt(index);
    } else {
      _cartProducts[index].quantity = quantity;
    }

    if (mounted) {
      setState(() {});
    }
  }

  double calculatePayment() {
    double total = 0;
    for (var i in _cartProducts) {
      total += (i.product.price * i.quantity);
    }

    return total;
  }

  void getProducts() async {
    _cartProducts = await CartServices.getCartProducts(
      context,
      mounted,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconContainer(
                    icon: SvgPicture.asset(
                      'assets/icons/three_dots.svg',
                      color: Colors.grey[400],
                    ),
                    padding: 5.0,
                  ),
                ],
              ),
            ),
          ),
          if (_cartProducts.isEmpty && !_isLoading) ...[
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const Center(
                  child: Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ] else ...[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _isLoading ? 3 : _cartProducts.length,
                (context, index) => _isLoading
                    ? const LoadingItem()
                    : ListProduct(
                        product: _cartProducts[index].product,
                        quantity: _cartProducts[index].quantity,
                        handleIconClick: (quantity) =>
                            updateCart(index, quantity),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                child: _isLoading
                    ? const PaymentLoading()
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Payment',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${calculatePayment().toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomButton(
                            onPressed: handleCheckoutBtn,
                            text: 'Checkout',
                            isLoading: false,
                            loadingText: '',
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

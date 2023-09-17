import 'package:buy_right/common/custom_button.dart';
import 'package:buy_right/features/checkout/widgets/address_details.dart';
import 'package:buy_right/features/checkout/widgets/price_details.dart';
import 'package:buy_right/features/checkout/widgets/top_row.dart';
import 'package:buy_right/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_product.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import 'checkout_services.dart';
import '../../common/list_product.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartProduct> cartProducts;
  final double total;

  const CheckoutScreen({
    Key? key,
    required this.cartProducts,
    required this.total,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final User providerUser;
  final _addressTextController = TextEditingController();
  bool _isLoading = false;

  void onOrderSuccess(String address) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider
        .setUser(userProvider.user.copyWith(cart: [], address: address));
    Navigator.pop(context);
  }

  void handlePayButton(double totalPrice) async {
    final typedAddress = _addressTextController.text.trim();

    if (providerUser.address.isEmpty && typedAddress.isEmpty) {
      return showSnackBar(context, 'Please add delivery address');
    }

    if (widget.cartProducts.isEmpty || totalPrice <= 0) {
      return showSnackBar(context, 'Something went wrong');
    }

    final addressToBeUsed =
        typedAddress.isNotEmpty ? typedAddress : providerUser.address;

    setState(() {
      _isLoading = true;
    });
    final isSuccess = await CheckoutServices.placeOrder(
      widget.cartProducts,
      totalPrice,
      addressToBeUsed,
      context,
      mounted,
    );

    if (isSuccess) {
      onOrderSuccess(addressToBeUsed);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _addressTextController.dispose();
  }

  @override
  void initState() {
    super.initState();
    providerUser = Provider.of<UserProvider>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopRow(),
                    AddressDetails(
                        addressTextController: _addressTextController),
                    const Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.cartProducts.length,
                (context, index) => ListProduct(
                  product: widget.cartProducts[index].product,
                  quantity: widget.cartProducts[index].quantity,
                  spacing: 20.0,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PriceDetails(price: widget.total),
                    CustomButton(
                      onPressed: () => handlePayButton(widget.total + 5.0),
                      text: 'Pay \$${(widget.total + 5.0).toStringAsFixed(2)}',
                      isLoading: _isLoading,
                      loadingText: 'Placing Order...',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

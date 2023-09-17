import 'package:buy_right/features/orders/orders_services.dart';
import 'package:buy_right/models/user.dart';
import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/list_product.dart';
import '../../../models/order.dart';
import '../../../utils/constants.dart';

class OrderContainer extends StatefulWidget {
  final Order order;

  const OrderContainer({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  late final User _providerUser;
  bool _showDetails = false;
  int _currentStep = 0;

  void changeOrderStatus(int status) {
    setState(() {
      _currentStep = status + 1;
    });

    OrdersServices.changeOrderStatus(widget.order.id, status + 1, context, mounted,);
  }

  @override
  void initState() {
    super.initState();
    _providerUser = Provider.of<UserProvider>(context, listen: false).user;
    _currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ).copyWith(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${widget.order.id}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              'Total payment: \$${widget.order.totalPrice.toStringAsFixed(2)}',
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              DateFormat('h:mm a, dd MMM yyyy').format(widget.order.createdAt),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              'Address ${widget.order.address}',
            ),
            const SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: () => setState(() {
                _showDetails = !_showDetails;
              }),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      _showDetails
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(_showDetails ? 'Hide details' : 'See details'),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _showDetails,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...widget.order.products
                      .map(
                        (e) => SizedBox(
                          child: ListProduct(
                            product: e.product,
                            quantity: e.quantity,
                            spacing: 8.0,
                          ),
                        ),
                      )
                      .toList(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Order Status',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stepper(
                    currentStep: _currentStep,
                    physics: const NeverScrollableScrollPhysics(),
                    controlsBuilder: (context, details) {
                      if (_providerUser.type == ADMIN && _currentStep < 3) {
                        return TextButton(
                          child: const Text('Done'),
                          onPressed: () =>
                              changeOrderStatus(details.currentStep),
                        );
                      }
                      return const SizedBox();
                    },
                    margin: const EdgeInsets.only(
                      left: 60.0,
                    ),
                    steps: [
                      Step(
                        title: const Text('Order Placed'),
                        content: const Text(
                          'Order is being placed, and it will be processed shortly.',
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Order Shipped'),
                        content: const Text(
                          'Your order has been shipped and is on its way to your address.',
                        ),
                        isActive: _currentStep >= 1,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Out for Delivery'),
                        content: const Text(
                          'Your order is currently out for delivery and will be arriving soon.',
                        ),
                        isActive: _currentStep >= 2,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Delivered'),
                        content: const Text(
                          'Your order has been successfully delivered. Enjoy your purchase!',
                        ),
                        isActive: _currentStep >= 3,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

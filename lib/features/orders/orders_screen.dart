import 'package:buy_right/features/orders/widgets/loading_item.dart';
import 'package:buy_right/features/orders/widgets/order_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import 'orders_services.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> _orders = [];
  bool _isLoading = true;
  late final bool _isAdmin;

  void getOrders() async {
    _orders = await OrdersServices.getAllOrders(
      context,
      _isAdmin ? true : false,
      mounted,
    );

    if (mounted) {
      setState(() {
      _isLoading = false;
    });
    }
  }

  @override
  void initState() {
    super.initState();

    _isAdmin =
        Provider.of<UserProvider>(context, listen: false).user.type == ADMIN;
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isAdmin ? 'Manage Orders' : 'My Orders',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          !_isLoading && _orders.isEmpty
              ? SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Text(
                        _isAdmin ? 'There is no order' : 'Your have no order',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: _isLoading ? 3 : _orders.length,
                    (context, index) => _isLoading
                        ? const LoadingItem()
                        : OrderContainer(
                            order: _orders[index],
                          ),
                  ),
                ),
        ],
      ),
    );
  }
}

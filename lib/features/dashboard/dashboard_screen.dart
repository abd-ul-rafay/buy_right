import 'package:buy_right/features/dashboard/widgets/bottom_bar.dart';
import 'package:buy_right/features/home/home_screen.dart';
import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../utils/constants.dart';
import '../analytics/analytics_screen.dart';
import '../cart/cart_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final User _providerUser;
  late final List<Widget> _pages;
  var _selectedTab = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  void initState() {
    super.initState();
    _providerUser = Provider.of<UserProvider>(context, listen: false).user;

    _pages = [
      const HomeScreen(),
      const OrdersScreen(),
      _providerUser.type == ADMIN
          ? const AnalyticsScreen()
          : CartScreen( afterPlacingOrder: () => _handleIndexChanged(1),),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomBar(
        selectedTab: _selectedTab,
        onTap: _handleIndexChanged,
      ),
    );
  }
}

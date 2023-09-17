import 'package:buy_right/models/user.dart';
import 'package:buy_right/providers/products_provider.dart';
import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardServices {
  static void logout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);

    userProvider.setUser(User(id: '', token: '', name: '', email: '', type: '', address: '', cart: [],));
    productProvider.setProducts([]);

    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AUTH_TOKEN_KEY);
  }
}

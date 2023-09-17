import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/order.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class OrdersServices {
  static Future<List<Order>> getAllOrders(
    BuildContext context,
    bool getOrdersOfAllUsers,
    bool mounted,
  ) async {
    final providerUser = Provider.of<UserProvider>(context, listen: false).user;

    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return [];
    }

    final query = getOrdersOfAllUsers ? '' : '?user=${providerUser.id}';

    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/api/user/get-all-orders$query'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 && mounted) {
        showSnackBar(context, responseData['err']);
        return [];
      }

      final List<Order> orders = [];

      for (var i in (responseData as List)) {
        orders.add(Order.fromJson(i));
      }

      return orders;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }

    return [];
  }

  static void changeOrderStatus(
    String orderId,
    int status,
    BuildContext context,
    bool mounted,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return;
    }

    try {
      final response = await http.patch(
        Uri.parse('$BASE_URL/api/admin/change-order-status'),
        body: jsonEncode({
          'orderId': orderId,
          'status': status,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'Application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 && mounted) {
        showSnackBar(context, responseData['err']);
        return;
      }
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }
  }
}

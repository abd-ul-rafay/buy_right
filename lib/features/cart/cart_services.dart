import 'dart:convert';
import 'package:buy_right/models/cart_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class CartServices {
  static Future<void> manageCart(
    String productId,
    int quantity,
    BuildContext context,
    bool mounted, {
    bool isFirstTime = false,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return;
    }

    try {
      final response = await http.patch(
        Uri.parse('$BASE_URL/api/user/manage-cart/$productId'),
        body: jsonEncode(
          {'quantity': quantity},
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'Application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 && mounted) {
        return showSnackBar(context, responseData['err']);
      }

      final alreadyPresent = userProvider.user.cart.any((p) => p == productId);
      if (!alreadyPresent) {
        userProvider.setUser(
          userProvider.user.copyWith(
            cart: [productId, ...userProvider.user.cart],
          ),
        );
      } else if (alreadyPresent && quantity == 0) {
        userProvider.setUser(
          userProvider.user.copyWith(
            cart: userProvider.user.cart.where((p) => p != productId).toList(),
          ),
        );
      }

      if (isFirstTime && mounted) {
        showSnackBar(context, 'Product added to cart');
      }
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }
  }

  static Future<List<CartProduct>> getCartProducts(
    BuildContext context,
    bool mounted,
  ) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/api/user/get-cart-products'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 && mounted) {
        showSnackBar(context, responseData['err']);
        return [];
      }

      final products = (responseData['cart'] as List<dynamic>)
          .map((product) => CartProduct.fromJson(product))
          .toList();

      return products;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }

    return [];
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/cart_product.dart';
import '../../models/product.dart';
import '../../providers/products_provider.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class CheckoutServices {
  static Future<bool> placeOrder(
    List<CartProduct> cartProducts,
    double totalPrice,
    String address,
    BuildContext context,
    bool mounted,
  ) async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return false;
    }

    final productsMap =
        cartProducts.map((product) => product.toJsonWithOnlyId()).toList();

    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/api/user/place-order'),
        body: jsonEncode({
          'products': productsMap,
          'totalPrice': totalPrice,
          'address': address,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'Application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 201 && mounted) {
        showSnackBar(context, responseData['err']);
        return false;
      }

      // change quantity in provider
      final updatedProducts = List<Product>.from(productsProvider.products);

      for (var cp in cartProducts) {
        final productIndex =
            updatedProducts.indexWhere((p) => p.id == cp.product.id);
        if (productIndex != -1) {
          updatedProducts[productIndex].quantity -= cp.quantity;
        }
      }

      productsProvider.setProducts(updatedProducts);

      if (mounted) {
        showSnackBar(context, 'Order placed successfully');
      }
      return true;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }

    return false;
  }
}

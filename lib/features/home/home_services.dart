import 'dart:convert';
import 'package:buy_right/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class HomeServices {
  static Future<void> getProducts(
    BuildContext context,
    bool mounted,
  ) async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);

    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/api/products'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 && mounted) {
        return showSnackBar(context, responseData['err']);
      }

      final List<Product> products = (responseData as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList();
      productsProvider.setProducts(products);
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }
  }
}

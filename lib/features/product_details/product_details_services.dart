import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../providers/products_provider.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class ProductDetailsServices {
  static Future<void> deleteProduct(
    String productId,
    BuildContext context,
    bool mounted,
  ) async {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('$BASE_URL/api/admin/delete-product'),
        body: jsonEncode({
          'productId': productId,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'Application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        if (mounted) {
          showSnackBar(context, responseData['err']);
        }
        return;
      }

      if (mounted) {
        showSnackBar(context, 'Product deleted successfully');
      }

      // remove product from provider
      final products = productsProvider.products;
      products.removeWhere((product) => product.id == productId);
      productsProvider.setProducts(products);
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }
  }
}

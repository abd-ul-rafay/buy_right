import 'dart:convert';
import 'dart:io';
import 'package:buy_right/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../providers/products_provider.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class AddProductServices {
  static void addProduct(
    BuildContext context,
    Product product,
    List<File> images,
    Function(String) onSuccess,
    bool mounted,
  ) async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return;
    }

    final cloudinary = CloudinaryPublic(
      'dahwtdeef',
      'hhdm7apm',
    );

    final imgUrls = <String>[];

    try {
      for (var img in images) {
        final res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            img.path,
            folder: 'BuyRight/${product.category}',
          ),
        );
        imgUrls.add(res.secureUrl);
      }

      product.images = imgUrls;

      final response = await http.post(
        Uri.parse('$BASE_URL/api/admin/add-product'),
        body: jsonEncode(
          product.toJson(),
        ),
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 201 && mounted) {
        showSnackBar(context, responseData['err']);
      }

      final createdProduct = Product.fromJson(responseData);
      productsProvider
          .setProducts([createdProduct, ...productsProvider.products]);

      onSuccess(createdProduct.name);
    } catch (err) {
      if (mounted) {
        showSnackBar(context,  err.toString());
      }
    }
  }
}

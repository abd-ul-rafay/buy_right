import 'dart:convert';
import 'package:buy_right/models/user.dart';
import 'package:buy_right/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future<bool> login(
    BuildContext context,
    String email,
    String password,
    bool mounted,
  ) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final response = await http.post(Uri.parse('$BASE_URL/api/auth/login'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {'Content-Type': 'application/json'});

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 && mounted) {
        showSnackBar(context, responseData['err']);
        return false;
      }

      final user = User.fromJson(responseData);
      userProvider.setUser(user);

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(AUTH_TOKEN_KEY, responseData['token']);
      return true;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }

    return false;
  }

  static Future<bool> register(BuildContext context, String name, String email,
      String password, bool mounted) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.post(
        Uri.parse('$BASE_URL/api/auth/register'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 201 && mounted) {
        showSnackBar(context, responseData['err']);
        return false;
      }

      final user = User.fromJson(responseData);
      userProvider.setUser(user);

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(AUTH_TOKEN_KEY, responseData['token']);
      return true;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }

    return false;
  }
}

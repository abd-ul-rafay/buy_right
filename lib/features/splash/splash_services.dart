import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';

class SplashServices {
  static Future<bool> getUser(BuildContext context, bool mounted) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString(AUTH_TOKEN_KEY);

    if (token == null) {
      return true; // true so that auth screen is shown
    }

    try {
      final response = await http.get(Uri.parse('$BASE_URL/api/user/get-user'),
          headers: {'Authorization': 'Bearer $token'});
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return false;
      }

      final user = User.fromJson(responseData);
      userProvider.setUser(user);
      return true;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }

    return false;
  }
}

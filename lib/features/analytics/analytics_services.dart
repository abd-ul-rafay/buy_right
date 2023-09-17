import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../utils/functions.dart';
import 'classes/sales.dart';

class AnalyticsServices {
  static Future<List<Sales>> getAnalytics(
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
        Uri.parse('$BASE_URL/api/admin/analytics'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 && mounted) {
        showSnackBar(context, responseData['err']);
        return [];
      }

      List<Sales> data = [];
      for (var key in (responseData as Map<String, dynamic>).keys) {
        data.add(Sales(category: key, sales: double.parse(responseData[key].toString())));
      }

      return data;
    } catch (err) {
      if (mounted) {
        showSnackBar(context, err.toString());
      }
    }

    return [];
  }
}

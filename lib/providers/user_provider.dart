import 'package:buy_right/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    token: '',
    name: '',
    email: '',
    type: '',
    address: '',
    cart: [],
  );

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

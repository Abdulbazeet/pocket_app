import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/models/userModel.dart';

final userProviderClass = Provider(
  (ref) => UserProvider(),
);

class UserProvider extends ChangeNotifier {
  UserModel _usermodel = UserModel(
      username: '',
      storeName: '',
      email: '',
      password: '',
      id: '',
      token: '',
      AdminStatus: false);

  UserModel get usermodel => _usermodel;
  void setUser(String user) {
    _usermodel = UserModel.fromJson(user);
    notifyListeners();
  }
}

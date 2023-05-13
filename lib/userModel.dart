import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? userName;
  String? password;

  void setUserCredentials(String? userName, String? password) {
    this.userName = userName;
    this.password = password;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:rideme_driver/features/user/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  //set user info
  set updateUserInfo(User user) {
    _user = user;
    notifyListeners();
  }
}

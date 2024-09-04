import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  set updateToken(String? token) {
    _token = token;
    notifyListeners();
  }
}

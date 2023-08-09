import 'dart:async';

import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  bool _isObscured = true;
  Timer? _timer;

  bool get isObscured => _isObscured;

  void changePasswordVisibility() {
    _isObscured = !_isObscured;
    notifyListeners();

    _timer?.cancel();

    if (_isObscured == false) {
      _timer = Timer(const Duration(seconds: 5), () {
        _isObscured = !_isObscured;
        _timer = null;
        notifyListeners();
      });
    }
  }
}

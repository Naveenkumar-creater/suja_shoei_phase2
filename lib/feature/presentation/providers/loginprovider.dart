import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/domain/entity/loginentity.dart';


class LoginProvider extends ChangeNotifier {
  loginEntity? _user;

  loginEntity? get user => _user;

  void setUser(loginEntity user) {
    _user = user;
    notifyListeners();
  }
}

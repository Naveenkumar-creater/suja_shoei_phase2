import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/domain/entity/operator_entity.dart';

class OperatorProvider extends ChangeNotifier {
  OperatorEntity? _user;

  OperatorEntity? get user => _user;

  void setUser(OperatorEntity user) {
    _user = user;

    notifyListeners();
  }
}
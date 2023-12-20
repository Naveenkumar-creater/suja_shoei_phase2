import 'package:flutter/material.dart';


import '../../domain/entity/intiate_pause_entity.dart';





class InitiateProvider extends ChangeNotifier {
  IntiatePauseEntity? _user;

  IntiatePauseEntity? get user => _user;

  void setUser(IntiatePauseEntity user) {
    _user = user;

    notifyListeners();
  }
}
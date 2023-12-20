import 'package:flutter/material.dart';

import '../../domain/entity/datapoint_entity.dart';

class DataPointProvider extends ChangeNotifier {
  DataPointEntity? _user;

  DataPointEntity? get user => _user;

  void setUser(DataPointEntity user) {
    _user = user;

    notifyListeners();
  }
}
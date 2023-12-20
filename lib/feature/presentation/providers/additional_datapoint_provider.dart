import 'package:flutter/material.dart';

import '../../domain/entity/addtional_datapoint_entity.dart';

class AdditionalDataPointProvider extends ChangeNotifier {
  
  AddtionalDataPointEntity? _user;

  AddtionalDataPointEntity? get user => _user;

  void setUser(AddtionalDataPointEntity user) {
    _user = user;

    notifyListeners();
  }
}
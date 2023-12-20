import 'package:flutter/material.dart';
import '../../domain/entity/st_submit_entity.dart';

class StSubmitProvider extends ChangeNotifier {
  StSubmitEntity? _user;

  StSubmitEntity? get user => _user;

  void setUser(StSubmitEntity user) {
    _user = user;

    notifyListeners();
  }
}



import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_dd_pd_entity.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_form_entity.dart';



class StFormDetailProvider extends ChangeNotifier {
  StFormDetailsEntity? _user;

  StFormDetailsEntity? get user => _user;

  void setUser(StFormDetailsEntity user) {
    _user = user;

    notifyListeners();
  }
}

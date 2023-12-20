

import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_dd_pd_entity.dart';

import '../../domain/entity/st_status_count_entity.dart';

class StProblemDescriptionProvider extends ChangeNotifier {
  StProblemDescriptionEntity? _user;

  StProblemDescriptionEntity? get user => _user;

  void setUser(StProblemDescriptionEntity user) {
    _user = user;

    notifyListeners();
  }
}

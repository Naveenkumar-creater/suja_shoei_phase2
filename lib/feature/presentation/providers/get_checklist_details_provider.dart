import 'package:flutter/material.dart';

import 'package:suja_shoie_app/feature/domain/entity/getchecklist_details_entity.dart';

class GetCheckListDetailsProvider extends ChangeNotifier {
  ChecklistDetailsEntity? _user;

  ChecklistDetailsEntity? get user => _user;

  void setUser(ChecklistDetailsEntity user) {
    _user = user;

    notifyListeners();
  }
}

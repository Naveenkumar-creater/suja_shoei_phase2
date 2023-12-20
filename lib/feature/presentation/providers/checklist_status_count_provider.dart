import 'package:flutter/material.dart';

import '../../domain/entity/checklist_status_count_entity.dart';

class CheckListStatusCountProvider extends ChangeNotifier {
  ChecklistStatusEntity? _user;

  ChecklistStatusEntity? get user => _user;

  void setUser(ChecklistStatusEntity user) {
    _user = user;

    notifyListeners();
  }
}

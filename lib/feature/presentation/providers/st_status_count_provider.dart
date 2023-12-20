

import 'package:flutter/material.dart';

import '../../domain/entity/st_status_count_entity.dart';

class SupportTicketStatusCountProvider extends ChangeNotifier {
  SupportTicketStatusEntity? _user;

  SupportTicketStatusEntity? get user => _user;

  void setUser(SupportTicketStatusEntity user) {
    _user = user;

    notifyListeners();
  }
}

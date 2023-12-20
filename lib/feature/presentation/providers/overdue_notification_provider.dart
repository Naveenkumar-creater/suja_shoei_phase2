import 'package:flutter/material.dart';
import 'package:suja_shoie_app/feature/domain/entity/loginentity.dart';
import 'package:suja_shoie_app/feature/domain/entity/overdue_notification_entity.dart';

class OverdueNotificationProvider extends ChangeNotifier {
  OverdueNotificationEntity? _user;

  OverdueNotificationEntity? get user => _user;

  void setUser(OverdueNotificationEntity user) {
    _user = user;
    notifyListeners();
  }
}

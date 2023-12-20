import 'package:flutter/material.dart';



import '../../domain/entity/check_list_entity.dart';

class QrScannerProvider extends ChangeNotifier {
  CheckListEntity? _user;

  CheckListEntity? get user => _user;

  void setUser(CheckListEntity userdata) {
    _user = userdata;

    notifyListeners();
  }
}
import 'package:flutter/material.dart';

import 'package:suja_shoie_app/feature/domain/entity/asst_list_entity.dart';

class AssetListProvider extends ChangeNotifier {
  AssetListEntity? _user;

  AssetListEntity? get user => _user;

  void setUser(AssetListEntity user) {
    _user = user;

    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import 'package:suja_shoie_app/feature/domain/entity/asst_list_entity.dart';

import '../../domain/entity/st_assetList_entity.dart';

class StAssetListProvider extends ChangeNotifier {
  SupportTicketAssetListEntity? _user;

  SupportTicketAssetListEntity? get user => _user;

  void setUser(SupportTicketAssetListEntity user) {
    _user = user;

    notifyListeners();
  }
}
import 'package:flutter/foundation.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_dd_assetdetail_entity.dart';

class StAssetDetailProvider extends ChangeNotifier{

  SupportTicketAssetDetailEntity ? _user;

  SupportTicketAssetDetailEntity? get user => _user;

  void setUser(SupportTicketAssetDetailEntity user ){

    _user=user;
    notifyListeners();

  }
}
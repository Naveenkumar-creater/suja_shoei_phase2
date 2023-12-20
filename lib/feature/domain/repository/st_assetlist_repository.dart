import 'package:suja_shoie_app/feature/domain/entity/st_assetList_entity.dart';

abstract class SupportTicketAssetListRepository{
  Future<SupportTicketAssetListEntity> getAssetList(int status,String token,String todatea);
}
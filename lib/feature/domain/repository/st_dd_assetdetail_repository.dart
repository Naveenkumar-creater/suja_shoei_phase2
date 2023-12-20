import 'package:suja_shoie_app/feature/domain/entity/st_dd_assetdetail_entity.dart';

abstract class SupportTicketAssetDetailRepository{

  Future<SupportTicketAssetDetailEntity> getAssetList(String token);
}
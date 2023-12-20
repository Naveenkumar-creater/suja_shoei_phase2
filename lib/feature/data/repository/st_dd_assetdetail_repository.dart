import 'package:suja_shoie_app/feature/domain/repository/st_dd_assetdetail_repository.dart';

import '../data_source/Remote/remote_abstract/st_dd_assetdetail_datasource.dart';
import '../model/st_asset_deail_model.dart';

class SupportTicketAssetDetailRepositoryImpl implements SupportTicketAssetDetailRepository{

  final SupportTicketAssetDetailDatasource supportTicketAssetDetailDatasource;

  SupportTicketAssetDetailRepositoryImpl(this.supportTicketAssetDetailDatasource);
  
  @override
  Future<SupportTicketAssetdetailModel> getAssetList(String token) async{
   return await supportTicketAssetDetailDatasource.getAssetList(token);
  }
  
}
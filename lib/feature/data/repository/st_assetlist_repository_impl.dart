import 'package:suja_shoie_app/feature/domain/entity/st_assetList_entity.dart';

import '../../domain/repository/st_assetlist_repository.dart';
import '../data_source/Remote/remote_abstract/st_assetlist_datasource.dart';

class SupportTicketAssetListRepositoryImpl implements SupportTicketAssetListRepository{
  final SupportTicketAssetListDatasource supportTicketAssetListDatasource;

  SupportTicketAssetListRepositoryImpl(this.supportTicketAssetListDatasource);

  @override
  Future<SupportTicketAssetListEntity> getAssetList(int status, String token, String todate) async {

    return await supportTicketAssetListDatasource.getAssetList(status, token, todate);
  }

}
import 'package:suja_shoie_app/feature/data/model/st_assetlist_model.dart';

import '../../../core/st_assetlist_apiclient.dart';
import '../remote_abstract/st_assetlist_datasource.dart';

class SupportTicketAssetlistDatasourceImpl implements SupportTicketAssetListDatasource{
  final SupportTicketAssetListApiclient supportTicketAssetListApiclient;

  SupportTicketAssetlistDatasourceImpl(this.supportTicketAssetListApiclient);
  
  @override
  Future<SupportTicketAssetListModel> getAssetList( int status, String token,String todate) async {
  final response =  await supportTicketAssetListApiclient.getAssetList(status, token, todate);
  final result = SupportTicketAssetListModel.fromJson(response);
  return  result;
  }
  

}
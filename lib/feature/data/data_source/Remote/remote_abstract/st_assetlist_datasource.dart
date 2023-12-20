import '../../../model/st_assetlist_model.dart';

abstract class SupportTicketAssetListDatasource{
  Future<SupportTicketAssetListModel> getAssetList(int status,String token, String todate);
}
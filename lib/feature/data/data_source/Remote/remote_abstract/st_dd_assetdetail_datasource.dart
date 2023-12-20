
import '../../../model/st_asset_deail_model.dart';

abstract class SupportTicketAssetDetailDatasource{

  Future<SupportTicketAssetdetailModel> getAssetList(String token);
}
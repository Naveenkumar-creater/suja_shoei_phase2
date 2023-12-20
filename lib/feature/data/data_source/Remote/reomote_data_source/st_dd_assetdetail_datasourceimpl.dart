import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_dd_assetdetail_datasource.dart';
import '../../../core/st_dd_assetdetail_apiclient.dart';
import '../../../model/st_asset_deail_model.dart';



class SupportTicketAssetDetailDatasourceImpl implements SupportTicketAssetDetailDatasource {
  final SupportTicketAssetDetailApiclient supportTicketAssetDetailApiclient;
SupportTicketAssetDetailDatasourceImpl(this.supportTicketAssetDetailApiclient);
@override
  Future<SupportTicketAssetdetailModel> getAssetList(String token) async{
  final response = await supportTicketAssetDetailApiclient.getAssetList(token); 
 return SupportTicketAssetdetailModel.fromJson(response);
  }
}
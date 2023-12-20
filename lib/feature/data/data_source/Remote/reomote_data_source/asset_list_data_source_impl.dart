import 'package:suja_shoie_app/feature/data/core/asset_list_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/asset_list_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/asset_list_model.dart';

class AssetListDataSourceimpl extends AssetListDataSource {
  final AssetListClient assetListClient;

  AssetListDataSourceimpl(this.assetListClient);

  @override
  Future<AssetListModel> getAssetList(
      int statusCount, String toDate, String token) async {
  try{  final response =
        await assetListClient.getAssetList(statusCount, toDate, token);

        if(response!=null){
          // ignore: avoid_print
          print(AssetListModel.fromJson(response));
          return AssetListModel.fromJson(response);
        }else{
          throw Exception("Response Data is Null");
        }
    
  }catch(e){
    rethrow;

  }

  }
}

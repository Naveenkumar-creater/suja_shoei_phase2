import 'package:suja_shoie_app/feature/data/model/asset_list_model.dart';

abstract class AssetListDataSource {
  Future<AssetListModel> getAssetList(
      int statusCount, String toDate, String token);
}

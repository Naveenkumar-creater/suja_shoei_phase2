import '../entity/asst_list_entity.dart';

abstract class AssetListRepository {
  Future<AssetListEntity> getAssetList(
      int statusCount, String toDate, String token);
}

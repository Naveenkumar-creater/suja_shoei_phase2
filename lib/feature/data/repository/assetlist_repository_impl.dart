import '../../domain/repository/asset_list_repository.dart';
import '../data_source/Remote/remote_abstract/asset_list_data_source.dart';
import '../model/asset_list_model.dart';

class AssetlistRepositoryImpl implements AssetListRepository {
  final AssetListDataSource assetListDataSource;

  AssetlistRepositoryImpl(this.assetListDataSource);

  @override
  Future<AssetListModel> getAssetList(
      int statusCount, String toDate, String token) async {
    AssetListModel assetListModel =
        await assetListDataSource.getAssetList(statusCount, toDate, token);
    // ignore: avoid_print
    print("statusCount type: ${statusCount.runtimeType}");
    // ignore: avoid_print
    print("statusCount value: $statusCount");
    return assetListModel;
  }
}

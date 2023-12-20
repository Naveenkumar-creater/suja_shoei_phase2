import 'package:suja_shoie_app/feature/domain/entity/asst_list_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/asset_list_repository.dart';

class AssetListUsecase {
  final AssetListRepository assetListRepository;

  AssetListUsecase(this.assetListRepository);

  Future<AssetListEntity> execute(
      int statusCount, String toDate, String token) async {
    return assetListRepository.getAssetList(statusCount, toDate, token);
  }
}

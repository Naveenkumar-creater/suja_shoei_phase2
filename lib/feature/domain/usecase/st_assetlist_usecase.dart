import 'package:suja_shoie_app/feature/domain/entity/st_assetList_entity.dart';

import '../repository/st_assetlist_repository.dart';

class SupportTicketAssetListUsecase{
  final SupportTicketAssetListRepository supportTicketAssetListRepository;
  SupportTicketAssetListUsecase(this.supportTicketAssetListRepository);

  Future<SupportTicketAssetListEntity> execute(int status, String token ,String todate)async{

  return await supportTicketAssetListRepository.getAssetList(status, token, todate);
  }
}
import 'package:suja_shoie_app/feature/domain/entity/st_dd_assetdetail_entity.dart';

import '../repository/st_dd_assetdetail_repository.dart';

class SupportTicketAssetDetailUsecase{
  final SupportTicketAssetDetailRepository supportTicketAssetDetailRepository;
 SupportTicketAssetDetailUsecase(this.supportTicketAssetDetailRepository);


  Future<SupportTicketAssetDetailEntity> execute (String token) async{
    return await supportTicketAssetDetailRepository.getAssetList(token);
  }
}
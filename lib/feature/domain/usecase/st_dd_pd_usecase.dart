import 'package:suja_shoie_app/feature/domain/entity/st_dd_pd_entity.dart';

import '../repository/st_dd_pd_repository.dart';

class StProblemDescriptionUsecase{
  final StProblemDescriptionRepository stProblemDescriptionRepository;
 StProblemDescriptionUsecase(this.stProblemDescriptionRepository);


  Future<StProblemDescriptionEntity> execute (String token) async{
    return await stProblemDescriptionRepository.getProblemDescription(token);
  }
}
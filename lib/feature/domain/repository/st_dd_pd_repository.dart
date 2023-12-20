import 'package:suja_shoie_app/feature/domain/entity/st_dd_assetdetail_entity.dart';

import '../entity/st_dd_pd_entity.dart';

abstract class StProblemDescriptionRepository{

  Future<StProblemDescriptionEntity> getProblemDescription
  (String token);
}
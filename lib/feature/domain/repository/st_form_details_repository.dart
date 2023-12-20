import 'package:suja_shoie_app/feature/domain/entity/st_dd_assetdetail_entity.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_form_entity.dart';

import '../entity/st_dd_pd_entity.dart';

abstract class StFormDetailsRepository{

  Future<StFormDetailsEntity> getFormDetails
  (int id,String token,String todate );
}
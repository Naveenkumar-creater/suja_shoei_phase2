
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_dd_pd_datasource.dart';
import 'package:suja_shoie_app/feature/data/model/st_form_model.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_dd_pd_entity.dart';

import '../../domain/repository/st_dd_pd_repository.dart';
import '../../domain/repository/st_form_details_repository.dart';
import '../data_source/Remote/remote_abstract/st_form_details_datasource.dart';

class StFormDetailsRepositoryImpl implements StFormDetailsRepository{

  final StFormDetailsDatasource stFormDetailsDatasource;

  StFormDetailsRepositoryImpl(this.stFormDetailsDatasource);
  

  @override
  Future<StFormDetailsModel> getFormDetails(int id, String token,String todate) async {
 return await stFormDetailsDatasource.getFormDetails(id,token,todate);
  }
  
}
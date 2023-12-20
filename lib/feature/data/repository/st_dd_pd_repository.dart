
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_dd_pd_datasource.dart';

import '../../domain/repository/st_dd_pd_repository.dart';
import '../model/st_dd_pd_model.dart';

class StProblemDescriptionRepositoryImpl implements StProblemDescriptionRepository{

  final StProblemDescriptionDatasource stProblemDescriptionDatasource;

  StProblemDescriptionRepositoryImpl(this.stProblemDescriptionDatasource);
  

  @override
  Future<StProblemDescriptionModel> getProblemDescription(String token) async {
 return await stProblemDescriptionDatasource.getProblemDescription(token);
  }
  
}
import '../../../model/st_dd_pd_model.dart';

abstract class StProblemDescriptionDatasource{

  Future<StProblemDescriptionModel> getProblemDescription(String token);
}
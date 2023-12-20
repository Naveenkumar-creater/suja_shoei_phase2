import 'package:suja_shoie_app/feature/data/core/st_dd_pd_apiclient.dart';
import '../../../model/st_dd_pd_model.dart';
import '../remote_abstract/st_dd_pd_datasource.dart';



class StProblemDescriptionDatasourceImpl implements StProblemDescriptionDatasource {
  final StProblemDescriptionApiclient stProblemDescriptionApiclient;
StProblemDescriptionDatasourceImpl(this.stProblemDescriptionApiclient);
@override
  Future<StProblemDescriptionModel> getProblemDescription(String token) async{
  final response = await stProblemDescriptionApiclient.getProblemDescription(token); 
 final result=StProblemDescriptionModel.fromJson(response);

 print(result);
 return result;
  }

}
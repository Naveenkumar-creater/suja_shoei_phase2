import 'package:suja_shoie_app/feature/data/core/st_dd_pd_apiclient.dart';
import '../../../core/st_form_apiclient.dart';
import '../../../model/st_dd_pd_model.dart';
import '../../../model/st_form_model.dart';
import '../remote_abstract/st_dd_pd_datasource.dart';
import '../remote_abstract/st_form_details_datasource.dart';



class StFormDetailsDatasourceImpl implements StFormDetailsDatasource {
  final StFormDetailsApiclient stFormDetailsApiclient;
StFormDetailsDatasourceImpl(this.stFormDetailsApiclient);
@override
  Future<StFormDetailsModel> getFormDetails(int id,String token,String todate) async{
  final response = await stFormDetailsApiclient.getFormDetails(id,token,todate); 
 final result=StFormDetailsModel.fromJson(response);

 print(result);
 return result;
  }
  

}
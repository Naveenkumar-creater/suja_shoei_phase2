import '../../../model/st_form_model.dart';

abstract class StFormDetailsDatasource{
  Future<StFormDetailsModel> getFormDetails(int id,String token,String todate);
}
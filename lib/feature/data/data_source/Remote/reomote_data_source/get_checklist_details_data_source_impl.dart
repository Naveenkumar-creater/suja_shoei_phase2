
import 'package:suja_shoie_app/feature/data/core/get_check_list_details_api_client%20.dart';

import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/get_checklist_deatils_data_source.dart';

import 'package:suja_shoie_app/feature/data/model/get_checklist_details_model.dart';

class GetCheckListdetailsDataSourceimpl extends GetCheckListDetailsDataSource {
  final GetCheckListDetailsClient getCheckListDetailsClient;

  GetCheckListdetailsDataSourceimpl(this.getCheckListDetailsClient);

  @override
  Future<ChecklistDetailsModel> getCheckListDetails(
      int planId, String toDate, String token,int acrpinspectionstatus) async {
    try {
      final response = await getCheckListDetailsClient.getCheckListDetails(
          planId, toDate, token,acrpinspectionstatus);

      if (response != null) {
        return ChecklistDetailsModel.fromJson(response);
      } else {
        throw Exception("Response Data is Null");
      }
    } catch (e) {
      throw e;
    }
  }
}

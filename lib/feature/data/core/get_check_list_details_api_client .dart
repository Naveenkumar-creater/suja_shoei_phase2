// ignore: file_names
// ignore: file_names
// ignore: file_names
import '../model/request_data_model.dart';
import 'api_constant.dart';

class GetCheckListDetailsClient {
  dynamic getCheckListDetails(
      int planId, String toDate, String token, int acrpinspectionstatus) async {
    ApiRequestDataModel requestData = ApiRequestDataModel(
      clientAuthToken: token,
      apiFor: "get_check_list_details",
      planId: planId,
      fromDateTime: ApiConstant.fromDate,
      toDateTime: toDate,
      acrpInspectionStatus: acrpinspectionstatus,
    );
    // final Map<String, dynamic> requestData = {
    //   "client_aut_token": token,
    //   "api_for": "get_check_list_details",
    //   "plan_id": planId,
    //   "from_date_time": "2023-08-01 10:00:00",
    //   "to_date_time": toDate,
    //   'acrp_inspection_status':2

    // };

    final apiConstant = ApiConstant();
    final headers = {
      'Content-Type': 'application/json',
    };

    return await apiConstant.makeApiRequest(
      url: ApiConstant.baseUrl,
      headers: headers,
      requestBody: requestData,
    );
  }
}

import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

import 'api_constant.dart';

class CheckListStatusClient {
  dynamic getStatusCount(int count, String toDate, String token) async {
    ApiRequestDataModel requestData = ApiRequestDataModel(
      clientAuthToken: token,
      apiFor: "check_list_status_count",
      checklistStatus: count,
      fromDateTime:ApiConstant.fromDate,
      toDateTime: toDate,
      
    );

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
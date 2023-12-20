import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

import 'api_constant.dart';

class SupportTicketStatusApiClient {
  dynamic getStatusCount(int count, String toDate, String token) async {
    ApiRequestDataModel requestData = ApiRequestDataModel(
      clientAuthToken: token,
      apiFor: "support_ticket_count ",
      supportticketstatus: count,
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
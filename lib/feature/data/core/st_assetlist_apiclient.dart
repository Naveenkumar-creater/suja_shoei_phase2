import 'package:suja_shoie_app/feature/data/core/api_constant.dart';
import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

class SupportTicketAssetListApiclient {
  dynamic getAssetList(int status, String token, String todate) {
    ApiRequestDataModel apiRequestbody = ApiRequestDataModel(
        apiFor: "asset_list_for_support_ticket",
        clientAuthToken: token,
        supportticketstatus: status,
        fromDateTime: ApiConstant.fromDate,
        toDateTime: todate);

    ApiConstant apiConstant = ApiConstant();
    final headers = {"content-Type": "application/json"};

    return apiConstant.makeApiRequest(
        url: ApiConstant.baseUrl,
        headers: headers,
        requestBody: apiRequestbody);
  }
}

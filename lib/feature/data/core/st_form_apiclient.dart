import 'package:suja_shoie_app/feature/data/core/api_constant.dart';
import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

class StFormDetailsApiclient {
  dynamic getFormDetails(int id,String token, String todate) {
    ApiRequestDataModel apiRequestDataModel = ApiRequestDataModel(
        apiFor: "support_ticket",
        clientAuthToken: token,
        supportticketid:id,
        fromDateTime: ApiConstant.fromDate,
        toDateTime: todate);
    final header = {"Content-Type": "application/json"};

    final apiconstant = ApiConstant();

    return apiconstant.makeApiRequest(
        url: ApiConstant.baseUrl,
        headers: header,
        requestBody: apiRequestDataModel);
  }
}

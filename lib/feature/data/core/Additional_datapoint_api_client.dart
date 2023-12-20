import '../model/request_data_model.dart';
import 'api_constant.dart';

class AdditionalDataPointClient {
  dynamic getAdditionalDataPoint(String token) async {
    ApiRequestDataModel requestData = ApiRequestDataModel(
      clientAuthToken: token,
      apiFor: "datapoint_mstr",
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


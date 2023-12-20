import '../model/request_data_model.dart';
import 'api_constant.dart';

class DataPointClient {
  dynamic getDataPoint(int acrdId, String token) async {
    ApiRequestDataModel requestData = ApiRequestDataModel(
      clientAuthToken: token,
      apiFor: "get_check_list_datapoints",
       acrdId: acrdId,

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
import '../model/request_data_model.dart';
import 'api_constant.dart';

class OverdueNotificationClient {
  dynamic getOverdueNotification( String token) async {
    // ApiRequestDataModel requestData = ApiRequestDataModel(
    //   clientAuthToken: token,
    //   apiFor: "getnotification",
     
    // );
    final Map<String, dynamic> requestData = {
"client_aut_token":  token,
"api_for": "getnotification"
};
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

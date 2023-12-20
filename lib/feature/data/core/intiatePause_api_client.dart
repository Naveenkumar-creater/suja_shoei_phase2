import 'package:suja_shoie_app/feature/data/core/api_constant.dart';
import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

class InitiatePauseClient {
  dynamic initiatePause(int id,String token, ) async {
    ApiRequestDataModel requestData = ApiRequestDataModel(
      clientAuthToken: token,
      apiFor: "timerstatus",
      planId: id,
      timeStatus: 2, 
    );

    ApiConstant apiConstant = ApiConstant();
    final headers = {"Content-Type": "application/json"};

    return await apiConstant.makeApiRequest(
        url: ApiConstant.baseUrl, headers: headers, requestBody: requestData);
  }
}

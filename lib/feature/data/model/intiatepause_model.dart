import 'package:suja_shoie_app/feature/domain/entity/intiate_pause_entity.dart';


class InitiatePauseModel extends IntiatePauseEntity {
 InitiatePauseModel({
    required int responseCode,
    required ResponseData responseData,
    required int wsReqId,
    required String responseMsg,
  }) : super(
          responseCode: responseCode,
          responseData: responseData,
          wsReqId: wsReqId,
          responseMsg: responseMsg,
        );

  factory InitiatePauseModel.fromJson(Map<String, dynamic> json) {
    return InitiatePauseModel(
     responseCode: json['response_code'],
      responseData: ResponseData.fromJson(json['response_data']),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}
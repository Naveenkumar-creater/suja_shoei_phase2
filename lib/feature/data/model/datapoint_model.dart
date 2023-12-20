
import '../../domain/entity/datapoint_entity.dart';


class DataPointModel extends DataPointEntity {
  DataPointModel({
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

  factory DataPointModel.fromJson(Map<String, dynamic> json) {
    return DataPointModel(
     responseCode: json['response_code'],
      responseData: ResponseData.fromJson(json['response_data']),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}

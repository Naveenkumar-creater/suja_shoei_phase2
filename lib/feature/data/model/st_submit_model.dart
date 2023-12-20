
import '../../domain/entity/st_submit_entity.dart';
class StSubmitModel extends StSubmitEntity {
  const StSubmitModel({
    required int? responseCode,
    required ResponseData responseData,
    required int wsReqId,
    required String responseMsg,
  }) : super(
          responseCode: responseCode,
          responseData: responseData,
          wsReqId: wsReqId,
          responseMsg: responseMsg,
        );

  factory StSubmitModel.fromJson(Map<String, dynamic> json) {
    return StSubmitModel(
            responseCode: json["response_code"],
            responseData:  ResponseData.fromJson(json["response_data"]),
            wsReqId: json["ws_req_id"],
            responseMsg: json["response_msg"],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      "response_code": responseCode,
      "response_data": responseData.toJson(),
      "ws_req_id": wsReqId,
      "response_msg": responseMsg,
    };
  }
}

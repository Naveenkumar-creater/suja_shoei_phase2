import '../../domain/entity/st_dd_pd_entity.dart';

class StProblemDescriptionModel extends StProblemDescriptionEntity {
    StProblemDescriptionModel({
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

  factory StProblemDescriptionModel.fromJson(Map<String, dynamic> json) {
    return StProblemDescriptionModel(
      responseCode: json['response_code'],
      responseData: ResponseData.fromJson(json['response_data']),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}









import '../../domain/entity/getchecklist_details_entity.dart';

class ChecklistDetailsModel extends ChecklistDetailsEntity {
  ChecklistDetailsModel({
    required int responseCode,
    required ModelResponseData responseData,
    required int wsReqId,
    required String responseMsg,
  }) : super(
          responseCode: responseCode,
          responseData: responseData,
          wsReqId: wsReqId,
          responseMsg: responseMsg,
        );

  factory ChecklistDetailsModel.fromJson(Map<String, dynamic> json) {
    return ChecklistDetailsModel(
      responseCode: json['response_code'],
      responseData: ModelResponseData.fromJson(json['response_data']),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}


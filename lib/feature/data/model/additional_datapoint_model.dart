
import '../../domain/entity/addtional_datapoint_entity.dart';

class AdditionalDatapointModel extends AddtionalDataPointEntity  {
  const AdditionalDatapointModel({
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

  factory AdditionalDatapointModel.fromJson(Map<String, dynamic> json) {
    final responseDataJson = json['response_data'];
    if (responseDataJson == null) {
      throw Exception('Response data is null.');
    }

    return AdditionalDatapointModel(
      responseCode: json['response_code'],
      responseData: ResponseData.fromJson(responseDataJson),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}


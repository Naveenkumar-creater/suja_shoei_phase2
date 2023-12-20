import '../../domain/entity/asst_list_entity.dart';

class AssetListModel extends AssetListEntity {
  const AssetListModel({
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

  factory AssetListModel.fromJson(Map<String, dynamic> json) {
    final responseDataJson = json['response_data'];
    if (responseDataJson == null) {
      throw Exception('Response data is null.');
    }

    return AssetListModel(
      responseCode: json['response_code'],
      responseData: ResponseData.fromJson(responseDataJson),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}


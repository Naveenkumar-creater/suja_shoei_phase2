// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:suja_shoie_app/feature/domain/entity/check_list_entity.dart';

class CheckListModel extends CheckListEntity {
  const CheckListModel({
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

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    final responseDataJson = json['response_data'];
    if (responseDataJson == null) {
      throw Exception('Response data is null.');
    }

    return CheckListModel(
      responseCode: json['response_code'],
      responseData: ResponseData.fromJson(responseDataJson),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}

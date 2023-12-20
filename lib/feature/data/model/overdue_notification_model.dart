import 'package:suja_shoie_app/feature/domain/entity/overdue_notification_entity.dart';

class OverdueNotificationModel extends OverdueNotificationEntity {
  const OverdueNotificationModel({
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
  
  factory OverdueNotificationModel.fromJson(Map<String, dynamic> json) {
    final responseDataJson = json['response_data'];
    if (responseDataJson == null) {
      throw Exception('Response data is null.');
    }

    return OverdueNotificationModel(
      responseCode: json['response_code'],
      responseData: ResponseData.fromJson(responseDataJson),
      wsReqId: json['ws_req_id'],
      responseMsg: json['response_msg'],
    );
  }
}

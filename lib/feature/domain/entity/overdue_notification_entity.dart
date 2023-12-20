import 'package:equatable/equatable.dart';

class OverdueNotificationEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

  const OverdueNotificationEntity({
    required this.responseCode,
    required this.responseData,
    required this.wsReqId,
    required this.responseMsg,
  });

  @override
  List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];
}

class ResponseData {
  final List<OverdueNotificationDataEntity> overdueNotificationDataEntity;

  ResponseData({
    required this.overdueNotificationDataEntity,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    final assetListJson = json['alert_notification']; // Updated key name
    // ignore: avoid_print
    print('Asset list JSON: $assetListJson'); // Print the assetListJson

    if (assetListJson == null) {
      throw Exception(
          'Asset list is null.'); // Throw an exception if asset list is null
    }

    final overdueNotificationData = (assetListJson as List)
        .map((item) => OverdueNotificationDataEntity.fromJson(item))
        .toList();

    return ResponseData(
      overdueNotificationDataEntity: overdueNotificationData,
    );
  }
}

class OverdueNotificationDataEntity {
  final String alndescription;
  final int alnrefdoc;
  final int userid;
  final int  alncriticality;
  final int alnrefid;
    final int alnescalationid;
      final int alntrantype;
        final String  alndate;
          final int alnid;
            final int alnto;
              final int alnstatus;
               

  OverdueNotificationDataEntity({
    required this.alndescription,
    required this.alnrefdoc,
    required this.userid,
    required this. alncriticality,
    required this.alnrefid,
    required this.alnescalationid,
    required this.alntrantype,
    required this. alndate,

    required this.alnid,
    required this.alnto,
    required this.alnstatus,
   
    
  });

  factory OverdueNotificationDataEntity.fromJson(Map<String, dynamic> json) {
    return OverdueNotificationDataEntity(
      alndescription: json['aln_description'],
      alnrefdoc: json['aln_ref_doc'],
      userid: json['user_id'],
      alncriticality: json['aln_criticality'],
      alnrefid: json['aln_ref_id'],
      alnescalationid: json['aln_escalation_id'],
      alntrantype: json['aln_tran_type'],
     alndate: json['aln_date'],
      alnid: json['aln_id'],
     alnto: json['aln_to'],
      alnstatus: json['aln_status'],

    );
  }
}


// {
//     "response_code": 1,
//     "response_data": {
//         "alert_notification": [
//             {
//                 "aln_description": "overdue",
//                 "aln_ref_doc": 0,
//                 "user_id": 0,
//                 "aln_criticality": 0,
//                 "aln_ref_id": 0,
//                 "aln_escalation_id": 0,
//                 "aln_tran_type": 0,
//                 "aln_date": "",
//                 "aln_id": 1,
//                 "aln_to": 1,
//                 "aln_status": 1
//             }
//         ]
//     },
//     "ws_req_id": 28420,
//     "response_msg": "Success"
// }
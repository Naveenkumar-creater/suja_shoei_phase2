import 'package:equatable/equatable.dart';

class StFormDetailsEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

  const StFormDetailsEntity({
    required this.responseCode,
    required this.responseData,
    required this.wsReqId,
    required this.responseMsg,
  });

  @override
  List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];
}


class ResponseData {
    ResponseData({
        required this.supportTicket,
    });

    final SupportTicket? supportTicket;

    factory ResponseData.fromJson(Map<String, dynamic> json){ 
        return ResponseData(
            supportTicket: json["support_ticket"] == null ? null : SupportTicket.fromJson(json["support_ticket"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "support_ticket": supportTicket?.toJson(),
    };

}

class SupportTicket {
    SupportTicket({
        required this.amSupTicketPriority,
        required this.amSupTicketAssetId,
        required this.images,
        required this.amSupTicketDate,
        required this.amSupTicketRaisedBy,
        required this.amSupTicketProblemDescription,
        required this.amSupTicketCriticality,
        required this.amSupTicketOrgId,
        required this.amSupTicketAssetCondition,
        required this.amSupTicketDeptId,
        required this.amsupticketproblemid,
         this.assetName
    });

    final int? amSupTicketPriority;
    final int? amSupTicketAssetId;
    final List<dynamic> images;
    final String? amSupTicketDate;
    final int? amSupTicketRaisedBy;
    final String? amSupTicketProblemDescription;
    final int? amSupTicketCriticality;
    final int? amSupTicketOrgId;
    final int? amSupTicketAssetCondition;
    final int? amSupTicketDeptId;
    final int ? amsupticketproblemid;
    final String? assetName;

    factory SupportTicket.fromJson(Map<String, dynamic> json){ 
        return SupportTicket(
            amSupTicketPriority: json["am_sup_ticket_priority"],
            amSupTicketAssetId: json["am_sup_ticket_asset_id"],
            images: json["images"],
            amSupTicketDate: json["am_sup_ticket_date"] ,
            amSupTicketRaisedBy: json["am_sup_ticket_raised_by"],
            amSupTicketProblemDescription: json["am_sup_ticket_problem_description"],
            amSupTicketCriticality: json["am_sup_ticket_criticality"],
            amSupTicketOrgId: json["am_sup_ticket_org_id"],
            amSupTicketAssetCondition: json["am_sup_ticket_asset_condition"],
            amSupTicketDeptId: json["am_sup_ticket_dept_id"],
            amsupticketproblemid:json['am_sup_ticket_problem_id'],
            assetName:json['asset_name']

        );
    }

    Map<String, dynamic> toJson() => {
        "am_sup_ticket_priority": amSupTicketPriority,
        "am_sup_ticket_asset_id": amSupTicketAssetId,
        "images": images.map((x) => x).toList(),
        "am_sup_ticket_date": amSupTicketDate,
        "am_sup_ticket_raised_by": amSupTicketRaisedBy,
        "am_sup_ticket_problem_description": amSupTicketProblemDescription,
        "am_sup_ticket_criticality": amSupTicketCriticality,
        "am_sup_ticket_org_id": amSupTicketOrgId,
        "am_sup_ticket_asset_condition": amSupTicketAssetCondition,
        "am_sup_ticket_dept_id": amSupTicketDeptId,
        "am_sup_ticket_problem_id":amsupticketproblemid,
        "asset_name":assetName
    };

}

//  "support_ticket": {
//       "am_sup_ticket_priority": 1,
//       "am_sup_ticket_asset_id": 72,
//       "images": [
//         "http://localhost:8080/btecMaintenance/document_viewimage/suja/2",
//         "http://localhost:8080/btecMaintenance/document_viewimage/suja/3"
//       ],
//       "am_sup_ticket_date": "2023-11-07 00:00:00",
//       "am_sup_ticket_raised_by": 71,
//       "am_sup_ticket_problem_description": "good",
//       "am_sup_ticket_criticality": 1,
//       "am_sup_ticket_org_id": 1,
//       "am_sup_ticket_asset_condition": 1,
//       "am_sup_ticket_problem_id": 1,
//       "am_sup_ticket_dept_id": 0
//     }

// {
//   "response_code": 1,
//   "response_data": {
//     "support_ticket": {
//       "am_sup_ticket_priority": 1,
//       "am_sup_ticket_asset_id": 72,
//       "images": [
//         "http://localhost:8080/btecMaintenance/document_viewimage/suja/2",
//         "http://localhost:8080/btecMaintenance/document_viewimage/suja/3"
//       ],
//       "am_sup_ticket_date": "2023-11-07 00:00:00",
//       "am_sup_ticket_raised_by": 71,
//       "am_sup_ticket_problem_description": "good",
//       "am_sup_ticket_criticality": 1,
//       "am_sup_ticket_org_id": 1,
//       "am_sup_ticket_asset_condition": 1,
//       "am_sup_ticket_problem_id": 1,
//       "am_sup_ticket_dept_id": 0
//     }
//   },
//   "ws_req_id": 44694,
//   "response_msg": "Success"
// }
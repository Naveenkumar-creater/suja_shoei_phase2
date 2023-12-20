import 'package:equatable/equatable.dart';
import 'package:suja_shoie_app/feature/domain/entity/addtional_datapoint_entity.dart';

class CheckListEntity extends Equatable {
  final int? responseCode;
  final ResponseData? responseData;
  final int? wsReqId;
  final String? responseMsg;

  const CheckListEntity({
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
    required this.checklist,
    required this.supportTicket,
  });

  final List<CheckListData> checklist;
  final List<SupportTicket> supportTicket;

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      checklist: json["check_list"] == null
          ? []
          : List<CheckListData>.from(
              json["check_list"]!.map((x) => CheckListData.fromJson(x))),
      supportTicket: json["support_ticket"] == null
          ? []
          : List<SupportTicket>.from(
              json["support_ticket"]!.map((x) => SupportTicket.fromJson(x))),
    );
  }
}

class CheckListData {
  CheckListData({
    required this.checklistname,
    required this.maintenancetypename,
    required this.assetname,
    required this.registerid,
    required this.checkliststatus,
    required this.assetbarcode,
    required this.checklistfrequency,
    required this.inspectiondate,
    required this.planid,
    required this.acrpassetId,
    required this.acrpactualinspectiontotime,
    // required this.acpinspectionDate
    // required this.acrpinspectionstatus,
  });

  final String checklistname;
  final String maintenancetypename;
  final String assetname;
  final int registerid;
  final int checkliststatus;
  final String assetbarcode;
  final int checklistfrequency;
  final String inspectiondate;
  final int planid;
  final String acrpactualinspectiontotime;
  // ignore: prefer_typing_uninitialized_variables
  final int acrpassetId;
  //  final int acrpinspectionstatus;

  // final String acpinspectionDate;

  factory CheckListData.fromJson(Map<String, dynamic> json) {
    return CheckListData(
      checklistname: json['check_list_name'],

      maintenancetypename: json['maintenance_type_name'],
      assetbarcode: json['asset_bar_code'],

      assetname: json['asset_name'],

      registerid: json['registerid'],

      checkliststatus: json['acrp_inspection_status'],
      checklistfrequency: json['checklist_frequency'],

      inspectiondate: json['acrp_inspection_date'],
      planid: json['acrp_id'],
      acrpassetId: json['acrp_asset_id'],
      acrpactualinspectiontotime: json['acrp_actual_inspection_to_time'],
      //  acpinspectionDate:json['acrp_actual_inspection_to_time']
      // acrpinspectionstatus:json['acrp_inspection_status'],
    );
  }
}

class SupportTicket {
  SupportTicket({
    required this.amSupTicketPriority,
    required this.amSupTicketSupportLevel,
    required this.amSupTicketDate,
    required this.amSupTicketId,
    required this.amSupTicketProblemDescription,
    required this.amSupTicketCriticality,
    required this.amSupTicketStatus,
    required this.amSupTicketSolution,
  });

  final int amSupTicketPriority;
  final int amSupTicketSupportLevel;
  final String amSupTicketDate;
  final int amSupTicketId;
  final String amSupTicketProblemDescription;
  final int amSupTicketCriticality;
  final int amSupTicketStatus;
  final String amSupTicketSolution;

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      amSupTicketPriority: json["am_sup_ticket_priority"],
      amSupTicketSupportLevel: json["am_sup_ticket_support_level"],
      amSupTicketDate: json["am_sup_ticket_date"],
      amSupTicketId: json["am_sup_ticket_id"],
      amSupTicketProblemDescription: json["am_sup_ticket_problem_description"],
      amSupTicketCriticality: json["am_sup_ticket_criticality"],
      amSupTicketStatus: json["am_sup_ticket_status"],
      amSupTicketSolution: json["am_sup_ticket_solution"],
    );
  }
}

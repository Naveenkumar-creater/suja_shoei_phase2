class ApiRequestDataModel {
  String? clientAuthToken;
  String apiFor;
  String? loginId;
  String? loginPassword;
  String? assetbarcode;
  String? clGroup;
  int? checklistStatus;
  int? inspectionstatus;
  int? statuscount;
  int? assetid;
  int? planId;
  int? acrdId;
  String? fromDateTime;
  String? toDateTime;
  String? clientId;
  String? personId;
  int? acrpInspectionStatus;
  int ? timeStatus;
  int ?machineStaus;
  int ? supportticketstatus;
 int ?supportticketid;

  ApiRequestDataModel(
      {this.clientAuthToken,
      required this.apiFor,
      this.timeStatus,
      this.assetid,
      this.personId,
      this.planId,
      this.acrdId,
      this.loginId,
      this.loginPassword,
      this.clGroup,
      this.checklistStatus,
      this.statuscount,
      this.fromDateTime,
      this.toDateTime,
      this.clientId,
      this.assetbarcode,
      this.acrpInspectionStatus,
      this.inspectionstatus,
      this.machineStaus,
      this.supportticketstatus,
      this.supportticketid
    });

  Map<String, dynamic> toJson() {
    return {
      'client_aut_token': clientAuthToken,
      'api_for': apiFor,
      "asset_id": assetid,
      'login_id': loginId,
      'login_password': loginPassword,
      'cl_group': clGroup,
      'checklist_status': checklistStatus,
      "status": statuscount,
      'from_date_time': fromDateTime,
      'to_date_time': toDateTime,
      'client_id': clientId,
      'asset_bar_code': assetbarcode,
      'plan_id': planId,
      'personId': personId,
      'acrd_id': acrdId,
      'acrp_inspection_status': acrpInspectionStatus,
      'inspection_status': inspectionstatus,
      'timer_status':timeStatus,
      "Machine_Status":machineStaus,
      "am_sup_ticket_status":supportticketstatus,
      "am_sup_ticket_id":supportticketid
    };
  }
}


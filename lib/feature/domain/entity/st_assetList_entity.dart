class SupportTicketAssetListEntity {
  int? responseCode;
  ResponseData? responseData;
  int? wsReqId;
  String? responseMsg;

  SupportTicketAssetListEntity({
    this.responseCode,
    this.responseData,
    this.wsReqId,
    this.responseMsg,
  });
  
}

class ResponseData {
    ResponseData({
        required this.assetListForSupportTicket,
    });

    final List<AssetListForSupportTicket> assetListForSupportTicket;

    factory ResponseData.fromJson(Map<String, dynamic> json){ 
        return ResponseData(
            assetListForSupportTicket: json["asset_list_for_support_ticket"] == null ? [] : List<AssetListForSupportTicket>.from(json["asset_list_for_support_ticket"]!.map((x) => AssetListForSupportTicket.fromJson(x))),
        );
    }

}

class AssetListForSupportTicket {
    AssetListForSupportTicket({
        required this.amSupTicketMaintenanceGroupId,
        required this.assetBarCode,
        required this.amSupTicketDate,
        required this.assetName,
        required this.amSupTicketRaisedBy,
        required this.locName,
        required this.amSupTicketStatus,
        required this.assetId,
        required this.amSupTicketDeptId,
    });

    final int? amSupTicketMaintenanceGroupId;
    final String? assetBarCode;
    final DateTime? amSupTicketDate;
    final String? assetName;
    final int? amSupTicketRaisedBy;
    final String? locName;
    final int? amSupTicketStatus;
    final int? assetId;
    final int? amSupTicketDeptId;

    factory AssetListForSupportTicket.fromJson(Map<String, dynamic> json){ 
        return AssetListForSupportTicket(
            amSupTicketMaintenanceGroupId: json["am_sup_ticket_maintenance_group_id"],
            assetBarCode: json["asset_bar_code"],
            amSupTicketDate: DateTime.tryParse(json["am_sup_ticket_date"] ?? ""),
            assetName: json["asset_name"],
            amSupTicketRaisedBy: json["am_sup_ticket_raised_by"],
            locName: json["loc_name"],
            amSupTicketStatus: json["am_sup_ticket_status"],
            assetId: json["asset_id"],
            amSupTicketDeptId: json["am_sup_ticket_dept_id"],
        );
    }

}

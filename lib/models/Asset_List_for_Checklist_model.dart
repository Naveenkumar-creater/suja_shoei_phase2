// ignore_for_file: file_names

class AssetLists {
  List<AssetListForChecklist>? assetListForChecklist;

  AssetLists.fromJson(Map<String, dynamic> json) {
    if (json['assetListForChecklist'] != null) {
      assetListForChecklist = <AssetListForChecklist>[];
      json['assetListForChecklist'].forEach((v) {
        assetListForChecklist!.add(AssetListForChecklist.fromJson(v));
      });
    }
  }
}

class AssetListForChecklist {
  String? acrpInspectionToTime;
  String? assetBarCode;
  String? assetName;
  String? acrpInspectionFromTime;
  int? assetType;
  String? inspectionDate;
  String? assetTypeName;
  String? locName;
  int? assetId;
  int? planId;
  int? assetLocId;
  int? inspectionStatus;

  AssetListForChecklist.fromJson(Map<String, dynamic> json) {
    acrpInspectionToTime = json['acrp_inspection_to_time'];
    assetBarCode = json['asset_bar_code'];
    assetName = json['asset_name'];
    acrpInspectionFromTime = json['acrp_inspection_from_time'];
    assetType = json['asset_type'];
    inspectionDate = json['inspection_date'];
    assetTypeName = json['asset_type_name'];
    locName = json['loc_name'];
    assetId = json['asset_id'];
    planId = json['plan_id'];
    assetLocId = json['asset_loc_id'];
    inspectionStatus = json['inspection_status'];
  }
}

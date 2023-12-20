import 'package:equatable/equatable.dart';

class AssetListEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

  const AssetListEntity({
    required this.responseCode,
    required this.responseData,
    required this.wsReqId,
    required this.responseMsg,
  });

  @override
  List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];
}

class ResponseData {
  final List<AssetListDataEntity> assetListForChecklistStatus;

  ResponseData({
    required this.assetListForChecklistStatus,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    final assetListJson = json['asset_list_for_checklist']; // Updated key name
    // ignore: avoid_print
    print('Asset list JSON: $assetListJson'); // Print the assetListJson

    if (assetListJson == null) {
      throw Exception(
          'Asset list is null.'); // Throw an exception if asset list is null
    }

    final assetListData = (assetListJson as List)
        .map((item) => AssetListDataEntity.fromJson(item))
        .toList();

    return ResponseData(
      assetListForChecklistStatus: assetListData,
    );
  }
}

class AssetListDataEntity {
  final String acrpInspectionToTime;
  final String assetBarCode;
  final int assetTagId;
  final String assetName;
  final String acrpInspectionFromTime;
  final String assetType;
  final String locName;
  final String assetTypeName;
  final int assetId;
  final int inspectionStatus;
  final String acrpinspectiondate;
  final String acmphtemplatename;

  AssetListDataEntity({
    required this.acrpinspectiondate,
    required this.acmphtemplatename,
    required this.acrpInspectionToTime,
    required this.assetBarCode,
    required this.assetTagId,
    required this.assetName,
    required this.acrpInspectionFromTime,
    required this.assetType,
    required this.locName,
    required this.assetTypeName,
    required this.assetId,
    required this.inspectionStatus,
  });

  factory AssetListDataEntity.fromJson(Map<String, dynamic> json) {
    return AssetListDataEntity(
      acrpInspectionToTime: json['acrp_inspection_to_time'],
      assetBarCode: json['asset_bar_code'],
      assetTagId: json['asset_tag_id'],
      assetName: json['asset_name'],
      acrpInspectionFromTime: json['acrp_inspection_from_time'],
      assetType: json['asset_type'],
      locName: json['loc_name'],
      assetTypeName: json['asset_type_name'],
      assetId: json['asset_id'],
      inspectionStatus: json['inspection_status'],
      acmphtemplatename: json['acmph_template_name'],
      acrpinspectiondate: json['acrp_inspection_date'],
    );
  }
}

import 'package:equatable/equatable.dart';

class SupportTicketAssetDetailEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

   const SupportTicketAssetDetailEntity({
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
        required this.assetMaster,
    });

    final List<AssetMaster> assetMaster;

    factory ResponseData.fromJson(Map<String, dynamic> json){ 
        return ResponseData(
            assetMaster: json["asset_master"] == null ? [] : List<AssetMaster>.from(json["asset_master"]!.map((x) => AssetMaster.fromJson(x))),
        );
    }
}


class AssetMaster {
    AssetMaster({
        required this.assetName,
        required this.assetId,
    });
    final String? assetName;
    final int? assetId;
    factory AssetMaster.fromJson(Map<String, dynamic> json){ 
        return AssetMaster(
            assetName: json["asset_name"],
            assetId: json["asset_id"],
        );
    }

}


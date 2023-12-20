import 'package:equatable/equatable.dart';

// class  GetMachineCountEntity extends Equatable {
//   int? responseCode;
//   ResponseData? responseData;
//   int? wsReqId;
//   String? responseMsg;

//   GetMachineCountEntity(
//       {this.responseCode, this.responseData, this.wsReqId, this.responseMsg});

//   @override
//   List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];
// }

// class ResponseData {
//    int? acrpInspectionStatusCount;
//   int? acrpAssetIdCount;
//   ResponseData({this.acrpInspectionStatusCount, this.acrpAssetIdCount});

//   factory ResponseData.fromJson(Map<String, dynamic> json) {
//     return ResponseData(
//       acrpAssetIdCount: json['acrp_asset_id_count'],
//         acrpInspectionStatusCount: json['acrp_inspection_status_count'],
//         );
//   }
// }

class GetMachineCountEntity extends Equatable {
  final int acrpInspectionStatusCount;
  final int acrpAssetIdCount;

  const GetMachineCountEntity(
      {required this.acrpInspectionStatusCount,
      required this.acrpAssetIdCount});

  @override
  List<Object?> get props => [acrpInspectionStatusCount, acrpAssetIdCount];
}

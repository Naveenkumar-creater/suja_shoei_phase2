import '../../domain/entity/get_machine_count_entity.dart';


// class GetmachineCountModel extends GetMachineCountEntity {
//   GetmachineCountModel({
//     required int responseCode,
//     required ResponseData responseData,
//     required int wsReqId,
//     required String responseMsg,
//   }) : super(
//           responseCode: responseCode,
//           responseData: responseData,
//           wsReqId: wsReqId,
//           responseMsg: responseMsg,
//         );

//   factory GetmachineCountModel.fromJson(Map<String, dynamic> json) {
//     return GetmachineCountModel(
//      responseCode: json['response_code'],
//       responseData: ResponseData.fromJson(json['response_data']),
//       wsReqId: json['ws_req_id'],
//       responseMsg: json['response_msg'],
//     );
//   }
// }

class GetmachineCountModel extends GetMachineCountEntity {
  const GetmachineCountModel(
      {required int acrpInspectionStatusCount, required int acrpAssetIdCount})
      : super(
            acrpInspectionStatusCount: acrpInspectionStatusCount,
            acrpAssetIdCount: acrpAssetIdCount);

  factory GetmachineCountModel.fromJson(Map<String, dynamic> json) {
    final machineStatus = json['response_data']['Machine_Status'];
    return GetmachineCountModel(
        acrpInspectionStatusCount:
           machineStatus['acrp_inspection_status_count'],
        acrpAssetIdCount: machineStatus['acrp_asset_id_count']);
  }
}


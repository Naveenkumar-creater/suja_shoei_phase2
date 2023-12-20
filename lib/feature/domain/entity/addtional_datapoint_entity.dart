import 'package:equatable/equatable.dart';


class AddtionalDataPointEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

  const AddtionalDataPointEntity({
    required this.responseCode,
    required this.responseData,
    required this.wsReqId,
    required this.responseMsg,
  });

  @override
  List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];


}

class ResponseData {
  final List<AdditionalDataPointDetailsEntity> additionaldatapointslist;

  ResponseData({
    required this.additionaldatapointslist,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      additionaldatapointslist: List<AdditionalDataPointDetailsEntity>.from(
          json['DataPintsMstr'].map(
              (detailJson) => AdditionalDataPointDetailsEntity.fromJson(detailJson))),
    );
  }
}

class AdditionalDataPointDetailsEntity extends Equatable {
  final int amdpDatapointId;
  final String amdpDatapointDescription;

  const AdditionalDataPointDetailsEntity({

    required this.amdpDatapointId,
    required this.amdpDatapointDescription,
  });

  @override
  List<Object?> get props => [
     amdpDatapointId,
        amdpDatapointDescription,
      ];

  factory AdditionalDataPointDetailsEntity.fromJson(Map<String, dynamic> json) {
    return AdditionalDataPointDetailsEntity(
      amdpDatapointId:json['amdp_datapoint_id'],
      amdpDatapointDescription: json['amdp_datapoint_description'],
    );
  }
}

import 'package:equatable/equatable.dart';


class DataPointEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

  const DataPointEntity({
    required this.responseCode,
    required this.responseData,
    required this.wsReqId,
    required this.responseMsg,
  });

  @override
  List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];
}

class ResponseData {

  final List<DataPointDetailsEntity> checklistDatapointsList;
    final List<String> detailImageUrl;

  ResponseData({
 
    required this.checklistDatapointsList,
       required this.detailImageUrl,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
  
      checklistDatapointsList: List<DataPointDetailsEntity>.from(
        json['checklist_datapoints_list'].map(
          (detailJson) => DataPointDetailsEntity.fromJson(detailJson),
        ),
      ),
          detailImageUrl: List<String>.from(json['detail_image_url']),
    );
  }

  get length => null;
}

class DataPointDetailsEntity {
  final int acrdpAcrdId;
  final int amdpDatapointId;
  final int acrdpId;
  final int acrdId;
  final int datapointValue;
  final int acrdpAcmdpId;
  final int acrdpAmdpDatapointId;
  final String amdpDatapointDescription;

  DataPointDetailsEntity({
    required this.acrdpAcrdId,
    required this.amdpDatapointId,
    required this.acrdpId,
    required this.acrdId,
    required this.datapointValue,
    required this.acrdpAcmdpId,
    required this.acrdpAmdpDatapointId,
    required this.amdpDatapointDescription,
  });

  factory DataPointDetailsEntity.fromJson(Map<String, dynamic> json) {
    return DataPointDetailsEntity(
      acrdpAcrdId: json['acrdp_acrd_id'],
      amdpDatapointId: json['amdp_datapoint_id'],
      acrdpId: json['acrdp_id'],
      acrdId: json['acrd_id'],
      datapointValue: json['datapoint_value'],
      acrdpAcmdpId: json['acrdp_acmdp_id'],
      acrdpAmdpDatapointId: json['acrdp_amdp_datapoint_id'],
      amdpDatapointDescription: json['amdp_datapoint_description'],
    );
  }
}
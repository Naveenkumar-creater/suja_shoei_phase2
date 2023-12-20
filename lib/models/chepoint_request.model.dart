class ChecklistDataPoint {
  int? amdpDatapointId;
  int? acrdpId;
  String? amdpDatapointDescription;
  String? acrdpDatapointValue;

  ChecklistDataPoint({
    this.amdpDatapointId,
    this.acrdpId,
    this.amdpDatapointDescription,
    this.acrdpDatapointValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'amdp_datapoint_id': amdpDatapointId,
      'acrdp_id': acrdpId,
      'amdp_datapoint_description': amdpDatapointDescription,
      'acrdp_datapoint_value': acrdpDatapointValue,
    };
  }
}

class ChecklistCheckpoint {
  int? acrdId;
  String? acrdCheckpointNotes;
  int? acrdCheckpointStatus;
  List<String>? images;
  List<ChecklistDataPoint>? datapoints;
  //  List<AdditionalData> additionalData;
  ChecklistCheckpoint({
    this.acrdId,
    this.acrdCheckpointNotes,
    this.acrdCheckpointStatus,
    this.images,
    this.datapoints,
    // required this.additionalData,
  });

  Map<String, dynamic> toJson() {
    return {
      'acrd_id': acrdId,
      'acrd_checkpoint_notes': acrdCheckpointNotes,
      'acrd_checkpoint_inspection_result': acrdCheckpointStatus,
      'images': images,
      'datapoints': datapoints?.map((dataPoint) => dataPoint.toJson()).toList(),
      // 'additionalData':
      //     additionalData.map((dataPoint) => dataPoint.toJson()).toList(),
    };
  }
}




class ChecklistRequest {
  String? clientAuthToken;
  int? operatorId;
  String? apiFor;
  String? toDateTime;
  String? fromDateTime;
  String? clientId;
  int? statusId;
  int? acrhAcmphId;
  int? acrhid;
  int? planid;
  List<String>? headerimage;
  List<ChecklistCheckpoint>? checkPoints;

  ChecklistRequest(
      {required this.clientAuthToken,
      required this.operatorId,
      required this.toDateTime,
      required this.headerimage,
      required this.apiFor,
      required this.clientId,
      required this.acrhAcmphId,
      required this.checkPoints,
      required this.fromDateTime,
      required this.statusId,
      required this.acrhid,
      required this.planid});

  Map<String, dynamic> toJson() {
    return {
      'client_aut_token': clientAuthToken,
      "header_image": headerimage,
      'operator_id': operatorId,
      'api_for': apiFor,
      'from_date_time': fromDateTime,
      'to_date_time': toDateTime,
      'client_id': clientId,
      'status_id': statusId,
      'acrh_acmph_id': acrhAcmphId,
      'acrh_id': acrhid,
      'acrp_id': planid,
      'check_points':
          checkPoints?.map((checkpoint) => checkpoint.toJson()).toList(),
    };
  }
}

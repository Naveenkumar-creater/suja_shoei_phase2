import 'package:equatable/equatable.dart';

class StProblemDescriptionEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

   const StProblemDescriptionEntity({
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
        required this.problemMstr,
    });

    final List<ProblemMstr> problemMstr;

    factory ResponseData.fromJson(Map<String, dynamic> json){ 
        return ResponseData(
            problemMstr: json["problem_mstr"] == null ? [] : List<ProblemMstr>.from(json["problem_mstr"]!.map((x) => ProblemMstr.fromJson(x))),
        );
    }

}

class ProblemMstr {
    ProblemMstr({
        required this.amProblemCodeId,
        required this.amMaintenanceGroupType,
        required this.amProblemCriticality,
        required this.amReasonDescription,
        required this.amProblemCode,
        required this.amProblemAssetType,
    });

    final int? amProblemCodeId;
    final int? amMaintenanceGroupType;
    final int? amProblemCriticality;
    final String? amReasonDescription;
    final String? amProblemCode;
    final int? amProblemAssetType;

    factory ProblemMstr.fromJson(Map<String, dynamic> json){ 
        return ProblemMstr(
            amProblemCodeId: json["am_problem_code_id"],
            amMaintenanceGroupType: json["am_maintenance_group_type"],
            amProblemCriticality: json["am_problem_criticality"],
            amReasonDescription: json["am_reason_description"],
            amProblemCode: json["am_problem_code"],
            amProblemAssetType: json["am_problem_asset_type"],
        );
    }

}

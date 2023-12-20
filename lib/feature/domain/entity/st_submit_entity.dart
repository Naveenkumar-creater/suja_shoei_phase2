 import 'package:equatable/equatable.dart';


class StSubmitEntity extends Equatable {
  final int? responseCode;
  final ResponseData responseData;
  final int wsReqId;
  final String responseMsg;

  const StSubmitEntity({
    required this.responseCode,
    required this.responseData,
    required this.wsReqId,
    required this.responseMsg,
  });

  @override
  List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];
}


class ResponseData {
    ResponseData({required this.json});
    final Map<String,dynamic> json;

    factory ResponseData.fromJson(Map<String, dynamic> json){ 
        return ResponseData(
        json: json
        );
    }

    Map<String, dynamic> toJson() => {
    };

}
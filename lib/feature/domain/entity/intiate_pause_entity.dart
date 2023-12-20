import 'package:equatable/equatable.dart';


class IntiatePauseEntity extends Equatable {
  int? responseCode;
  ResponseData? responseData;
  int? wsReqId;
  String? responseMsg;

  IntiatePauseEntity(
      {this.responseCode, this.responseData, this.wsReqId, this.responseMsg});

      @override
  List<Object?> get props => [responseCode, responseData, wsReqId, responseMsg];

}

class ResponseData {
  String? message;

  ResponseData({
  this.message,
  });


 factory ResponseData.fromJson(Map<String, dynamic> json) {
  return ResponseData(message: json['message'] );
  }
}

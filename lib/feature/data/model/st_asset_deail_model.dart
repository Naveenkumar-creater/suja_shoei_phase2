// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/entity/st_dd_assetdetail_entity.dart';

class SupportTicketAssetdetailModel extends SupportTicketAssetDetailEntity {
  
  SupportTicketAssetdetailModel({
    required int responseCode,
    required ResponseData responseData,
    required int wsReqId,
    required String responseMsg,
  }) : super(
          responseCode: responseCode,
          responseData: responseData ,
          wsReqId: wsReqId,
          responseMsg: responseMsg,
        );
    factory SupportTicketAssetdetailModel.fromJson(Map<String, dynamic> json){ 
        return SupportTicketAssetdetailModel(
            responseCode: json["response_code"],
            responseData:  ResponseData.fromJson(json["response_data"]),
            wsReqId: json["ws_req_id"],
            responseMsg: json["response_msg"],
        );
    }
}


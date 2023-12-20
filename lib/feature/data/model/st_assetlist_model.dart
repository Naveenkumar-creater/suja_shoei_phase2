import '../../domain/entity/st_assetList_entity.dart';

class SupportTicketAssetListModel extends SupportTicketAssetListEntity {
    SupportTicketAssetListModel({
        required this.responseCode,
        required this.responseData,
        required this.wsReqId,
        required this.responseMsg,
    }): super(
          responseCode: responseCode,
          responseData: responseData ,
          wsReqId: wsReqId,
          responseMsg: responseMsg,
        );

    final int? responseCode;
    final ResponseData? responseData;
    final int? wsReqId;
    final String? responseMsg;

    factory SupportTicketAssetListModel.fromJson(Map<String, dynamic> json){ 
        return SupportTicketAssetListModel(
            responseCode: json["response_code"],
            responseData:  ResponseData.fromJson(json["response_data"]),
            wsReqId: json["ws_req_id"],
            responseMsg: json["response_msg"],
        );
    }

}


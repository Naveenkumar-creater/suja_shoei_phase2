import 'package:suja_shoie_app/feature/data/core/api_constant.dart';
import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

class SupportTicketAssetDetailApiclient{
  dynamic getAssetList(String token){

    ApiRequestDataModel apiRequestDataModel=ApiRequestDataModel(apiFor: "get_asset_details_for_support_ticket",clientAuthToken: token);
     final header ={
      "Content-Type":"application/json"
     } ;

     final apiconstant=ApiConstant();
     
     return apiconstant.makeApiRequest(url: ApiConstant.baseUrl, headers: header, requestBody: apiRequestDataModel);
     
       }
}
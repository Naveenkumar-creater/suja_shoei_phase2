import 'package:suja_shoie_app/feature/data/model/st_submit_model.dart';

import '../../../../domain/entity/check_list_entity.dart';
import '../../../core/st_submit_api_client.dart';
import '../../../model/st_status_model.dart';

import '../remote_abstract/st_submit_datasource.dart';

class StSubmitDatasourceimpl extends StSubmitDataSource {
  final SupportTicketSubmitsApiClient supportTicketSubmitsApiClient;

  StSubmitDatasourceimpl(this.supportTicketSubmitsApiClient);

 
  
  @override
  Future<StSubmitModel> submitSupportTicket(Map<String,dynamic> supportTicket, String token) async{
   final response =
        await supportTicketSubmitsApiClient.submitSupportTicket( supportTicket,token);

    final result = StSubmitModel.fromJson(response);

    // ignore: avoid_print
    print(result);

    return result;
  }
}
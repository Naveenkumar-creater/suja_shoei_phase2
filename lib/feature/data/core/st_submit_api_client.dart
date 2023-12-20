import 'package:suja_shoie_app/feature/data/model/request_data_model.dart';

import '../../domain/entity/check_list_entity.dart';
import 'api_constant.dart';

class SupportTicketSubmitsApiClient {
  dynamic submitSupportTicket(Map<String,dynamic> supportTicket, String token) async {
final requestBody={
          'client_aut_token': token,
          'api_for':"save_checklist",
           "support_ticket_model":supportTicket
        };

     final apiConstant = ApiConstant();
      final headers = {
      'Content-Type': 'application/json',
    };

    return await apiConstant.makeApiRequest(
      url: ApiConstant.baseUrl,
      headers: headers,
      requestBody: requestBody,
    );
  }
}
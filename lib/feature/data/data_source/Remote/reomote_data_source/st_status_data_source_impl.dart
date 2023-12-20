import '../../../core/st_status_api_client.dart';
import '../../../model/st_status_model.dart';
import '../remote_abstract/st_status_data_source.dart';

class SupportTicketDataSourceimpl extends SupportTicketStatusDataSource {
  final SupportTicketStatusApiClient supportTicketStatusClient;

  SupportTicketDataSourceimpl(this.supportTicketStatusClient);

  @override
  Future<SupportTicketStatusModel> getSupportTicketStatusCount(
      int count, String toDate, String token) async {
    final response =
        await supportTicketStatusClient.getStatusCount(count, toDate, token);

    final result = SupportTicketStatusModel.fromJson(response);

    // ignore: avoid_print
    print(result);

    return result;
  }
}

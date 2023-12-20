import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_status_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/st_status_model.dart';
import '../../domain/repository/st_status_count_repository.dart';

class SupportTicketRepositoryImpl implements SupportTicketStausRepository {
  final SupportTicketStatusDataSource supportTicketStatusDataSource;

  SupportTicketRepositoryImpl(this.supportTicketStatusDataSource);

  @override
  Future<SupportTicketStatusModel> getSupportTicketStatusCount(
      int count, String toDate, String token) async {
    SupportTicketStatusModel supportTicketStatusModel =
        await supportTicketStatusDataSource.getSupportTicketStatusCount(count, toDate, token);
    return supportTicketStatusModel;
  }

}

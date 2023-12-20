import 'package:suja_shoie_app/feature/data/model/checklist_status_model.dart';
import 'package:suja_shoie_app/feature/data/model/st_status_model.dart';

abstract class SupportTicketStatusDataSource {
  Future<SupportTicketStatusModel> getSupportTicketStatusCount(
      int count, String toDate, String token);
}

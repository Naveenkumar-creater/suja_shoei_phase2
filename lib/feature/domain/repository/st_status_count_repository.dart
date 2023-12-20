
import '../entity/st_status_count_entity.dart';



abstract class SupportTicketStausRepository {
  Future<SupportTicketStatusEntity> getSupportTicketStatusCount(
      int count, String toDate, String token);
}

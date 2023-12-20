import '../entity/st_status_count_entity.dart';
import '../repository/st_status_count_repository.dart';


class SupportTicketStatusCountUseCase {
  final SupportTicketStausRepository supportTicketStatusRepository;

  SupportTicketStatusCountUseCase(this.supportTicketStatusRepository);

  Future<SupportTicketStatusEntity> execute(
      int count, String toDate, String token) async {
    return supportTicketStatusRepository.getSupportTicketStatusCount(
        count, toDate, token);
  }
}

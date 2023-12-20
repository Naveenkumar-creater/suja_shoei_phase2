import 'package:suja_shoie_app/feature/domain/entity/st_status_count_entity.dart';


class SupportTicketStatusModel extends SupportTicketStatusEntity {
  const SupportTicketStatusModel({
    required int count,
  }) : super(count: count);

  factory SupportTicketStatusModel.fromJson(Map<String, dynamic> json) {
    final checklistStatus = json['response_data']['support_ticket_count'];
    return SupportTicketStatusModel(
      count: checklistStatus['count'],
    );
  }
}

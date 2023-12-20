import 'package:suja_shoie_app/feature/domain/entity/overdue_notification_entity.dart';

abstract class OverdueNotificationRepository {
  Future<OverdueNotificationEntity> getOverdueNotification(
    String token);
}

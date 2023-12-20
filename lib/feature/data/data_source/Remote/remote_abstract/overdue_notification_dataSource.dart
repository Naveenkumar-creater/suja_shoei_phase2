import 'package:suja_shoie_app/feature/data/model/operator_model.dart';
import 'package:suja_shoie_app/feature/data/model/overdue_notification_model.dart';

abstract class OverdueNotificationDataSource {
  Future<OverdueNotificationModel> getOverdueNotification(
      String token);
}

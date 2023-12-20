import 'package:suja_shoie_app/feature/domain/entity/overdue_notification_entity.dart';

import '../../domain/repository/overdue_notification_repository.dart';
import '../data_source/Remote/remote_abstract/overdue_notification_dataSource.dart';

import '../model/check_list_model.dart';
import '../model/overdue_notification_model.dart';

class OverdueNotificationRepositoryImpl
    implements OverdueNotificationRepository {
  final OverdueNotificationDataSource overdueNotificationDataSource;

  OverdueNotificationRepositoryImpl(this.overdueNotificationDataSource);

  @override
  Future<OverdueNotificationModel> getOverdueNotification(
 String token) async {
    OverdueNotificationModel overdueNotificationModel =
        await overdueNotificationDataSource.getOverdueNotification(
            token);

    return overdueNotificationModel;
  }
}

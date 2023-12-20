import 'package:suja_shoie_app/feature/domain/entity/asst_list_entity.dart';
import 'package:suja_shoie_app/feature/domain/entity/overdue_notification_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/asset_list_repository.dart';
import 'package:suja_shoie_app/feature/domain/repository/overdue_notification_repository.dart';

class OverdueNotificationUsecase {
  final OverdueNotificationRepository overdueNotificationRepository;

  OverdueNotificationUsecase(this.overdueNotificationRepository);

  Future<OverdueNotificationEntity> execute( String token) async {
    return await  overdueNotificationRepository.getOverdueNotification(token);
  }
}

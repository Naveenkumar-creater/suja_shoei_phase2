import 'package:suja_shoie_app/feature/data/core/asset_list_api_client.dart';
import 'package:suja_shoie_app/feature/data/core/overdue_notification_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/asset_list_data_source.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/operator_data_source.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/overdue_notification_dataSource.dart';
import 'package:suja_shoie_app/feature/data/model/asset_list_model.dart';
import 'package:suja_shoie_app/feature/data/model/overdue_notification_model.dart';

class OverdueNotificationDataSourceimpl extends OverdueNotificationDataSource {
  final OverdueNotificationClient overdueNotificationClient;

  OverdueNotificationDataSourceimpl(this.overdueNotificationClient);

  @override
  Future<OverdueNotificationModel> getOverdueNotification(
      String token) async {
    try {
      final response =
          await overdueNotificationClient.getOverdueNotification( token);

      if (response != null) {
        // ignore: avoid_print
        print(OverdueNotificationModel.fromJson(response));
        return OverdueNotificationModel.fromJson(response);
      } else {
        throw Exception("Response Data is Null");
      }
    } catch (e) {
      rethrow;
    }
  }
}

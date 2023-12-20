import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';
import 'package:suja_shoie_app/feature/data/core/overdue_notification_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/overdue_notification_data_source_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/overdue_notification_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/entity/overdue_notification_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/overdue_notification_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/overdue_notification_usecase.dart';
import 'package:suja_shoie_app/feature/presentation/providers/overdue_notification_provider.dart';

import '../../data/data_source/Remote/remote_abstract/overdue_notification_dataSource.dart';

class OverdueNotificationService {
  Future<void> getOverdueNotification({
    required BuildContext context,
    // required int count,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-686";

      OverdueNotificationClient overdueNotificationClient =
          OverdueNotificationClient();
      OverdueNotificationDataSource overdueNotificationDataSource =
          OverdueNotificationDataSourceimpl(overdueNotificationClient);
      OverdueNotificationRepository overdueNotificationRepository =
          OverdueNotificationRepositoryImpl(overdueNotificationDataSource);
      OverdueNotificationUsecase overdueNotificationUsecase =
          OverdueNotificationUsecase(overdueNotificationRepository);

      OverdueNotificationEntity user =
          await overdueNotificationUsecase.execute( token);

      // ignore: use_build_context_synchronously
      var assetliststatus =
          // ignore: use_build_context_synchronously
          Provider.of<OverdueNotificationProvider>(context, listen: false);

      assetliststatus.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

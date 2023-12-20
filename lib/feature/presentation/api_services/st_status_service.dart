import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../constant/utils/show_snakbar.dart';
import '../../data/core/st_status_api_client.dart';
import '../../data/data_source/Remote/remote_abstract/st_status_data_source.dart';
import '../../data/data_source/Remote/reomote_data_source/st_status_data_source_impl.dart';
import '../../data/repository/st_status_repository_impl.dart';
import '../../domain/entity/st_status_count_entity.dart';
import '../../domain/repository/st_status_count_repository.dart';
import '../../domain/usecase/st_status_count_usecase.dart';
import '../providers/st_status_count_provider.dart';

class SupportTicketStatusService {
  Future<void> getStatusCount({
    required BuildContext context,
    required int count,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-626";

      SupportTicketStatusApiClient supportTicketClient =
          SupportTicketStatusApiClient();
      // ignore: non_constant_identifier_names
      SupportTicketStatusDataSource supportTicketData =
          SupportTicketDataSourceimpl(supportTicketClient);
      SupportTicketStausRepository supportTicketRepository =
          SupportTicketRepositoryImpl(supportTicketData);
      SupportTicketStatusCountUseCase supportTicketUseCase =
          SupportTicketStatusCountUseCase(supportTicketRepository);

      SupportTicketStatusEntity user =
          await supportTicketUseCase.execute(count, toDate, token);

      var supportTicketstatus =
          // ignore: use_build_context_synchronously
          Provider.of<SupportTicketStatusCountProvider>(context, listen: false);

      supportTicketstatus.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

// void showSnackBar(BuildContext? context, String message) {
//   if (context != null) {
//     final snackBar = SnackBar(
//       backgroundColor: Colors.amber[400],
//       content:
//           Center(child: Text(message, style: TextStyle(color: Colors.black))),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }

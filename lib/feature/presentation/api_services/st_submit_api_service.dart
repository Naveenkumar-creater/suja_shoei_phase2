import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/data/core/st_submit_api_client.dart';
import 'package:suja_shoie_app/feature/data/repository/st_submit_repository_impl.dart';
import 'package:suja_shoie_app/feature/presentation/providers/st_submit_provider.dart';


import '../../../constant/utils/show_snakbar.dart';
import '../../data/data_source/Remote/remote_abstract/st_submit_datasource.dart';
import '../../data/data_source/Remote/reomote_data_source/st_submit_data_source_impl.dart';
import '../../domain/repository/st_submit_repository.dart';
import '../../domain/usecase/st_submit_usecase.dart';

class SupportTicketSubmitService {
  Future<void> submitSuportTicket({
    required BuildContext context,
    required String token,
    required Map<String, dynamic> supportTicket,

  }) async {
    try {
      // SharedPreferences pref = await SharedPreferences.getInstance();
      // String token = pref.getString("client_token") ?? "";

      // DateTime now = DateTime.now();
      // String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-626";

      SupportTicketSubmitsApiClient supportTicketSubmitsApiClient =
          SupportTicketSubmitsApiClient();
      // ignore: non_constant_identifier_names
      StSubmitDataSource stSubmitDataSource =
         StSubmitDatasourceimpl(supportTicketSubmitsApiClient);
      StSubmitRepository  stSubmitRepository =
          StSubmitRepositoryImpl(stSubmitDataSource);
      StSubmitUsecase supportTicketUseCase =
          StSubmitUsecase(stSubmitRepository);

 final user = await supportTicketUseCase.execute(supportTicket,token);
 
      var submit =
          // ignore: use_build_context_synchronously
          Provider.of<StSubmitProvider
>(context, listen: false);

      submit.setUser(user);
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

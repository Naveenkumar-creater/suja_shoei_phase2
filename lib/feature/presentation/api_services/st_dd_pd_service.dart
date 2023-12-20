import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/core/st_dd_pd_apiclient.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_dd_pd_datasource.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/st_dd_pd_datasource_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/st_dd_pd_repository.dart';
import 'package:suja_shoie_app/feature/domain/repository/st_dd_pd_repository.dart';


import '../../../constant/utils/show_snakbar.dart';
import '../../data/core/st_status_api_client.dart';
import '../../data/data_source/Remote/remote_abstract/st_status_data_source.dart';
import '../../data/data_source/Remote/reomote_data_source/st_status_data_source_impl.dart';
import '../../data/repository/st_status_repository_impl.dart';
import '../../domain/entity/st_dd_pd_entity.dart';
import '../../domain/entity/st_status_count_entity.dart';
import '../../domain/repository/st_status_count_repository.dart';
import '../../domain/usecase/st_dd_pd_usecase.dart';
import '../../domain/usecase/st_status_count_usecase.dart';
import '../providers/st_dd_pd_provider.dart';
import '../providers/st_status_count_provider.dart';

class StProblemDescriptionService {
  Future<void> getproblemDescription({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "murali-2234";

      StProblemDescriptionApiclient supportTicketClient =
          StProblemDescriptionApiclient();
      // ignore: non_constant_identifier_names
      StProblemDescriptionDatasource supportTicketData =
          StProblemDescriptionDatasourceImpl(supportTicketClient);
      StProblemDescriptionRepository supportTicketRepository =
          StProblemDescriptionRepositoryImpl(supportTicketData);
     StProblemDescriptionUsecase supportTicketUseCase =
          StProblemDescriptionUsecase(supportTicketRepository);

      StProblemDescriptionEntity user =
          await supportTicketUseCase.execute( token);

      var supportTicketstatus =
          // ignore: use_build_context_synchronously
          Provider.of<StProblemDescriptionProvider>(context, listen: false);

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

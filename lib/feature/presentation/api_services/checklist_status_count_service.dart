import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/core/checklist_status_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/checklist_status_data_source.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/checklist_status_data_source_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/checklist_status_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/entity/checklist_status_count_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/checklist_status_count_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/checklist_status_count_usecase.dart';

import '../../../constant/utils/show_snakbar.dart';
import '../providers/checklist_status_count_provider.dart';

class ChecklistStatusService {
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

      CheckListStatusClient checkListClient = CheckListStatusClient();
      // ignore: non_constant_identifier_names
      CheckListStatusDataSource CheckListData =
          CheckListDataSourceimpl(checkListClient);
      CheckListStausRepository checklistRepository =
          ChecklistRepositoryImpl(CheckListData);
      CheckListStatusCountUseCase checkListUseCase =
          CheckListStatusCountUseCase(checklistRepository);

      ChecklistStatusEntity user =
          await checkListUseCase.execute(count, toDate, token);

      var checkliststatus =
          // ignore: use_build_context_synchronously
          Provider.of<CheckListStatusCountProvider>(context, listen: false);

      checkliststatus.setUser(user);
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

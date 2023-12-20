import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';

import '../../data/core/checklist_api_client.dart';
import '../../data/data_source/Remote/remote_abstract/checklist_data_source.dart';
import '../../data/data_source/Remote/reomote_data_source/checklist_data_source_impl.dart';
import '../../data/repository/checklist_repository_impl.dart';
import '../../domain/entity/check_list_entity.dart';
import '../../domain/repository/checklist_repository.dart';
import '../../domain/usecase/checklist_usecase.dart';
import '../providers/checklist_provider.dart';

class CheckListService {
  Future<void> getCheckList({
    required BuildContext context,
    required int id,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-686";

      CheckListClient checkListClient = CheckListClient();
      CheckListDataSource checkListData =
          CheckListDataSourceimpl(checkListClient);
      CheckListRepository checklistRepository =
         ChecklistRepositoryImpl(checkListData);
      CheckListUsecase checkListUseCase = CheckListUsecase(checklistRepository);

      CheckListEntity user =
          await checkListUseCase.execute(id, toDate, token);

      // ignore: use_build_context_synchronously
      var assetliststatus = Provider.of<CheckListProvider>(context, listen: false);

      assetliststatus.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

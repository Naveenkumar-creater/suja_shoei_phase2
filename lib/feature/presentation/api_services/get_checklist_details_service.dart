import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/get_checklist_deatils_data_source.dart';
import 'package:suja_shoie_app/feature/data/repository/get_checklist_Details_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/entity/getchecklist_details_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/get_checklist_details_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/get_checklist_Details_usecase.dart';

import '../../../constant/utils/show_snakbar.dart';
import '../../data/core/get_check_list_details_api_client .dart';
import '../../data/data_source/Remote/reomote_data_source/get_checklist_details_data_source_impl.dart';
import '../providers/get_checklist_details_provider.dart';

class GetChecklistService {
 Future<void> getCheckListDetails({
    required BuildContext context,
    required int planId,
    required int acrpinspectionstatus
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

        // String token = "admin-698";

      GetCheckListDetailsClient getCheckListDetailsClient =
          GetCheckListDetailsClient();
      GetCheckListDetailsDataSource getCheckListDetailsDataSource =
          GetCheckListdetailsDataSourceimpl(getCheckListDetailsClient);
      GetCheckListDetailsRepository getCheckListDetailsRepository =
          GetChecklistDetailsRepositoryImpl(getCheckListDetailsDataSource);
      GetCheckListdetailsUseCase getCheckListdetailsUseCase =
          GetCheckListdetailsUseCase(getCheckListDetailsRepository);

      ChecklistDetailsEntity user =
          await getCheckListdetailsUseCase.execute(planId, toDate, token,acrpinspectionstatus);

      var checkliststatus =
          // ignore: use_build_context_synchronously
          Provider.of<GetCheckListDetailsProvider>(context, listen: false);

      checkliststatus.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}



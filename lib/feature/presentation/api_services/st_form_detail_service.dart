import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_form_details_datasource.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/st_form_details_datasource_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/st_form_details_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/repository/st_form_details_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/st_form_details_usecase.dart';
import '../../../constant/utils/show_snakbar.dart';
import '../../data/core/st_form_apiclient.dart';
import '../providers/st_form_detail_provider.dart';


class SupportTicketFormService {
  Future getFormDetails({
    required BuildContext context,
    required int id
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "murali-2234";

      StFormDetailsApiclient stFormDetailsApiclient = StFormDetailsApiclient();
      // ignore: non_constant_identifier_names
      StFormDetailsDatasource stFormDetailsDatasource =
          StFormDetailsDatasourceImpl(stFormDetailsApiclient);
      StFormDetailsRepository stFormDetailsRepository =
          StFormDetailsRepositoryImpl(stFormDetailsDatasource);
     StFormDetailsUsecase stFormDetailsUsecase =
          StFormDetailsUsecase(stFormDetailsRepository);

   final user =
          await stFormDetailsUsecase.execute(id, token, toDate);

      var formDeatil =
          // ignore: use_build_context_synchronously
          Provider.of<StFormDetailProvider>(context, listen: false);

      formDeatil.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}


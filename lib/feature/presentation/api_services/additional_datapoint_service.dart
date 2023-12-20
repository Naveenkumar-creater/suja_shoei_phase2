import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/additional_datapoint_datasource.dart';

import '../../../constant/utils/show_snakbar.dart';
import '../../data/core/Additional_datapoint_api_client.dart';
import '../../data/data_source/Remote/reomote_data_source/additional_datapoint_data_source_impl.dart';
import '../../data/repository/additional_datapoint_repository_impl.dart';
import '../../domain/entity/addtional_datapoint_entity.dart';
import '../../domain/repository/additional_datapoint_repository.dart';
import '../../domain/usecase/additional_datapoint_usecase.dart';
import '../providers/additional_datapoint_provider.dart';


class AdditionalDataPointService {
  Future getAdditionalDatapoint({
    required BuildContext context,

  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      // DateTime now = DateTime.now();
      // String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "vijay-1569";

      AdditionalDataPointClient additionalDataPointClient = AdditionalDataPointClient();
      // ignore: non_constant_identifier_names
      AdditionalDataPointDataSource  additionalDataPointData =
          AdditionalDataPointDataSourceimpl(additionalDataPointClient);
        AdditionalDataPointRepository additionaldataPointRepository =
            AdditionalDataPointRepositoryImpl(additionalDataPointData);
     AdditionalDataPointUseCase additionaldataPointUseCase = AdditionalDataPointUseCase (additionaldataPointRepository);

     AddtionalDataPointEntity additionalData =
          await additionaldataPointUseCase.execute(token);

      var additionaldataPointValue =
          // ignore: use_build_context_synchronously
          Provider.of<AdditionalDataPointProvider>(context, listen: false);

      additionaldataPointValue.setUser(additionalData);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

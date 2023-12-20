import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/domain/repository/datapoint_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/datapoint_usecase.dart';

import '../../../constant/utils/show_snakbar.dart';
import '../../data/core/datapoint_api_client.dart';
import '../../data/data_source/Remote/remote_abstract/datapoint_data_source.dart';
import '../../data/data_source/Remote/reomote_data_source/datapoint_data_source_impl.dart';
import '../../data/repository/datapoint_repository_impl.dart';
import '../../domain/entity/datapoint_entity.dart';
import '../providers/datapoint_provider.dart';

class DataPointService {
  Future getDatapoints({
    required BuildContext context,
    required int acrdId,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      // DateTime now = DateTime.now();

      // String token = "admin-626";

      DataPointClient dataPointClient = DataPointClient();
      // ignore: non_constant_identifier_names
      DataPointDataSource dataPointData =
          DataPointDataSourceimpl(dataPointClient);
      DataPointRepository dataPointRepository =
          DataPointRepositoryImpl(dataPointData);
      DataPointUseCase dataPointUseCase = DataPointUseCase(dataPointRepository);

      DataPointEntity user =
          await dataPointUseCase.execute(acrdId, token);

      var dataPointValue =
          // ignore: use_build_context_synchronously
          Provider.of<DataPointProvider>(context, listen: false);

      dataPointValue.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

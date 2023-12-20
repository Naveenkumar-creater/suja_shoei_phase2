import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/core/operator_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/operator_data_source.dart';
import 'package:suja_shoie_app/feature/data/repository/operator_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/entity/operator_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/operator_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/operator_usecase.dart';
import 'package:suja_shoie_app/feature/presentation/providers/operator_provider.dart';

import '../../../constant/utils/show_snakbar.dart';
import '../../data/data_source/Remote/reomote_data_source/operator_data_source_impl.dart';

class OperatorService {
  Future<void> getOperatorName({
    required BuildContext context,
    required String personId,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-626";

      OperatorClient operatorClient = OperatorClient();
      // ignore: non_constant_identifier_names
      OperatorDataSource OperatorData =
            OperatorDataSourceimpl(operatorClient);
      OperatorRepository operatorsRepository =
           OperatorRepositoryImpl(OperatorData);
      OperatorUseCase operatorUseCase =
          OperatorUseCase(operatorsRepository);

      OperatorEntity data =
          await operatorUseCase.execute(personId, toDate, token);

      var operatorname =
          // ignore: use_build_context_synchronously
          Provider.of<OperatorProvider>(context, listen: false);

 operatorname.setUser(data);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}



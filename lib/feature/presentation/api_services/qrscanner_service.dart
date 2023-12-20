import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';
import 'package:suja_shoie_app/feature/data/core/qrscanner_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/qrscanner_data_aource.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/qrscanner_data_source_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/qrscanner_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/repository/qrscanner_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/qrscanner_usecase.dart';
import 'package:suja_shoie_app/feature/presentation/providers/qrscanner_provider.dart';

import '../../domain/entity/check_list_entity.dart';


class QrScannerService {
  Future<void> getCheckList({
    required BuildContext context,
    required String barcode,
  }) async {
    try {
      
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      // DateTime now = DateTime.now();
      // String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-698";

      QrScannerClient  qrScannerClient =  QrScannerClient();
      QrScannerDataSource  qrScannerData =
          QrScannerDataSourceimpl( qrScannerClient);
      QrScannerRepository  qrScannerRepository =
         QrScannerRepositoryImpl( qrScannerData);
    QrScannerUsecase qrScannerUsecase = QrScannerUsecase ( qrScannerRepository);

      CheckListEntity user =
          await qrScannerUsecase.execute(barcode, token);

      // ignore: use_build_context_synchronously
      var qrScannerChecklist = Provider.of<QrScannerProvider>(context, listen: false);

      qrScannerChecklist.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

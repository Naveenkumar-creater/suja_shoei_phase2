import 'dart:async';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';
import 'package:suja_shoie_app/feature/data/core/st_dd_assetdetail_apiclient.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_dd_assetdetail_datasource.dart';
import 'package:suja_shoie_app/feature/data/repository/st_dd_assetdetail_repository.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_dd_assetdetail_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/st_dd_assetdetail_repository.dart';
import 'package:suja_shoie_app/feature/presentation/di/st_asset_get_it.dart' as getIt;
import '../../data/data_source/Remote/reomote_data_source/st_dd_assetdetail_datasourceimpl.dart';
import '../../domain/usecase/st_dd_assetdetail_usecase.dart';
import '../providers/st_dd_assetsetail_provider.dart';

class StAssetDetailService {  
  Future<void> getAssetList({
    required BuildContext context,
  
  }) async {
    try {
      // unawaited(getIt.init());
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "murali-2234";

      SupportTicketAssetDetailApiclient supportTicketAssetDetailApiclient = SupportTicketAssetDetailApiclient();
      // ignore: non_constant_identifier_names
      SupportTicketAssetDetailDatasource stFormDetailsDatasource =
          SupportTicketAssetDetailDatasourceImpl(supportTicketAssetDetailApiclient);
      SupportTicketAssetDetailRepository supportTicketAssetDetailRepository =
          SupportTicketAssetDetailRepositoryImpl(stFormDetailsDatasource);
     SupportTicketAssetDetailUsecase supportTicketAssetDetailUsecase =
          SupportTicketAssetDetailUsecase(supportTicketAssetDetailRepository);
    
      // SupportTicketAssetDetailUsecase stAssetList = getIt.getAssetInstance<SupportTicketAssetDetailUsecase>(); 

      SupportTicketAssetDetailEntity user =
          await supportTicketAssetDetailUsecase.execute(token);

      var assetliststatus =
      
          Provider.of<StAssetDetailProvider>(context, listen: false);

      assetliststatus.setUser(user);

    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

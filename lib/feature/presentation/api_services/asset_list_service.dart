import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';
import 'package:suja_shoie_app/feature/data/core/asset_list_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/asset_list_data_source.dart';
import 'package:suja_shoie_app/feature/data/repository/assetlist_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/entity/asst_list_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/asset_list_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/asset_list_usecase.dart';
import 'package:suja_shoie_app/feature/presentation/providers/asset_list_provider.dart';

import '../../data/data_source/Remote/reomote_data_source/asset_list_data_source_impl.dart';
import '../providers/notification_provider.dart';

class AssetListService {  
  Future<void> getAssetList({
    required BuildContext context,
    required int count,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "admin-626";

      AssetListClient assetListClient = AssetListClient();
      AssetListDataSource assetListData =
          AssetListDataSourceimpl(assetListClient);
      AssetListRepository assetlistRepository =
          AssetlistRepositoryImpl(assetListData);
      AssetListUsecase checkListUseCase = AssetListUsecase(assetlistRepository);

      AssetListEntity user =
          await checkListUseCase.execute(count, toDate, token);

      var assetliststatus =
          // ignore: use_build_context_synchronously
          Provider.of<AssetListProvider>(context, listen: false);

      assetliststatus.setUser(user);

      var notifiaction= Provider.of<NotificationProvider>(context, listen: false);

       notifiaction.setUser(user);
    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';

import 'package:suja_shoie_app/feature/data/core/st_assetlist_apiclient.dart';

import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/st_assetlist_datasource.dart';

import 'package:suja_shoie_app/feature/data/repository/st_assetlist_repository_impl.dart';

import 'package:suja_shoie_app/feature/domain/entity/st_assetList_entity.dart';

import 'package:suja_shoie_app/feature/domain/repository/st_assetlist_repository.dart';

import 'package:suja_shoie_app/feature/domain/usecase/st_assetlist_usecase.dart';



import '../../data/data_source/Remote/reomote_data_source/st_assetlist_datasource_impl.dart';

import '../providers/st_assetlist_provider.dart';

class StAssetListService {  
  Future<void> getAssetList({
    required BuildContext context,
    required int count,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString("client_token") ?? "";

      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // String token = "murali-2110";

      SupportTicketAssetListApiclient stassetListClient = SupportTicketAssetListApiclient();
      SupportTicketAssetListDatasource stassetListData =
         SupportTicketAssetlistDatasourceImpl (stassetListClient);
      SupportTicketAssetListRepository stassetlistRepository =
          SupportTicketAssetListRepositoryImpl(stassetListData);
      SupportTicketAssetListUsecase stAssetListUseCase = SupportTicketAssetListUsecase(stassetlistRepository);

       SupportTicketAssetListEntity user =
          await stAssetListUseCase.execute(count,token, toDate);

      var assetliststatus =
          // ignore: use_build_context_synchronously
          Provider.of<StAssetListProvider>(context, listen: false);

      assetliststatus.setUser(user);

    } catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

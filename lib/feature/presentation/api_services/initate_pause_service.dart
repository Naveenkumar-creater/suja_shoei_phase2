
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/feature/data/core/intiatePause_api_client.dart';
import 'package:suja_shoie_app/feature/data/repository/initiate_pause_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/usecase/initiate_pause_usecase.dart';

import '../../../constant/utils/show_snakbar.dart';
import '../../data/data_source/Remote/remote_abstract/intiate_pause_datasource.dart';
import '../../data/data_source/Remote/reomote_data_source/initiate_pause_data_source-impl.dart';
import '../../domain/entity/intiate_pause_entity.dart';
import '../../domain/repository/initiate_pause_repository.dart';
import '../providers/initiate_pause_provider.dart';

class InitiatePauseService{
  Future<void>initiatePause({
    required BuildContext context,
    required int id,
  })
async {
try{
SharedPreferences pref= await SharedPreferences.getInstance();
String token=pref.getString('client_token')??"";

InitiatePauseClient initiatePauseClient=InitiatePauseClient();
InititatePauseDatasource intitatePauseDatasource= InitiatePauseDatasourceImpl(initiatePauseClient);
InitiatePauseRepository initiatePauseRepository=InitiatePauseRepositoryImpl(intitatePauseDatasource);
InitiatePauseUsecase initiatePauseUsecase=InitiatePauseUsecase(initiatePauseRepository);

IntiatePauseEntity user = await initiatePauseUsecase.execute(id, token);
  var cancelstatus =
          // ignore: use_build_context_synchronously
          Provider.of<InitiateProvider>(context , listen: false);

cancelstatus.setUser(user);


} catch (e) {
      ShowError.showAlert(context, e.toString());
    }
  }
}

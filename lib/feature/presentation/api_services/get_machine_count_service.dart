import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';
import 'package:suja_shoie_app/feature/data/core/get_machine_count_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/get_machine_count_datasource.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/get_machine_count_datasource_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/get_machine_count_repository_impl.dart';
import 'package:suja_shoie_app/feature/domain/entity/get_machine_count_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/get_machine_count_repository.dart';
import 'package:suja_shoie_app/feature/domain/usecase/get_machine_count_usecase.dart';

import '../providers/get_machine_count_provider.dart';

class GetmachineCountService{
Future<void>getMachineCount({
  required BuildContext context,
 required int machineStatus


})async{
  try{
   SharedPreferences pref = await SharedPreferences.getInstance();
   String token = pref.getString("client_token") ?? "";
   
      DateTime now = DateTime.now();
      String toDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      GetMachineCountClient getmachinecount=GetMachineCountClient();
      GetMachineCountDatasource getMachinecountData= GetMachineCountDatasourceImpl(getmachinecount);
      GetMachineCountRepository getMachineCountRepository = GetMachineCountRepositoryImpl(getMachinecountData);

      GetMachineCountUsecase getMachineCountUsecase = GetMachineCountUsecase(getMachineCountRepository);

      GetMachineCountEntity Count=  await getMachineCountUsecase.execute(machineStatus, toDate, token);

      var machineCount =Provider.of<GetMachineCountProvider>(context,listen: false);

      return machineCount.setUser(Count);


  }catch(e){
      ShowError.showAlert(context, e.toString());
  }
}
 
}
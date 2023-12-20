import 'package:suja_shoie_app/feature/data/core/get_machine_count_api_client.dart';

import '../../../model/get_machine_count_model.dart';
import '../remote_abstract/get_machine_count_datasource.dart';

class GetMachineCountDatasourceImpl extends GetMachineCountDatasource{

  final GetMachineCountClient getMachineCountClient;

  GetMachineCountDatasourceImpl(this.getMachineCountClient);

  
  @override
  Future<GetmachineCountModel> getMachineCOunt(int machinStatus, String todate, String token) async{
 final response=await  getMachineCountClient.getmachinecount(machinStatus, todate, token);

  final result=GetmachineCountModel.fromJson(response);
  return result;
  }

  
}
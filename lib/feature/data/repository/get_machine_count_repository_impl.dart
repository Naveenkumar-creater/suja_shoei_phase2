import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/get_machine_count_datasource.dart';
import 'package:suja_shoie_app/feature/data/model/get_machine_count_model.dart';

import '../../domain/repository/get_machine_count_repository.dart';

class GetMachineCountRepositoryImpl implements GetMachineCountRepository{

 final GetMachineCountDatasource getMachinecountDatasource;

  GetMachineCountRepositoryImpl(this.getMachinecountDatasource);

@override
  Future<GetmachineCountModel>getMachineCount(int machineStatus,String todate, String token)async{

    GetmachineCountModel response= await getMachinecountDatasource.getMachineCOunt(machineStatus, todate, token);

    return response;
}

}
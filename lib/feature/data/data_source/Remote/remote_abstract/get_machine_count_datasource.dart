import '../../../model/get_machine_count_model.dart';

abstract class GetMachineCountDatasource{
  Future<GetmachineCountModel>getMachineCOunt(int machinStatus,String todate,String token);
}
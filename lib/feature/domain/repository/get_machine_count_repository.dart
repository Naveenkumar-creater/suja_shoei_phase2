import 'package:suja_shoie_app/feature/domain/entity/get_machine_count_entity.dart';

abstract class GetMachineCountRepository{
  Future<GetMachineCountEntity>getMachineCount(int machineStatus, String todate, String token);
}
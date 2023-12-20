import 'package:suja_shoie_app/feature/domain/entity/get_machine_count_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/get_machine_count_repository.dart';

class GetMachineCountUsecase{
final GetMachineCountRepository getMachineCountRepository;

  GetMachineCountUsecase(this.getMachineCountRepository);

  Future<GetMachineCountEntity>execute(int machineStatus, String todate, String token){
    return  getMachineCountRepository.getMachineCount(machineStatus, todate, token);

  }

}


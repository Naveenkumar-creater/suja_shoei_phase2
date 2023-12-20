import 'package:suja_shoie_app/feature/domain/repository/operator_repository.dart';

import '../entity/operator_entity.dart';

class OperatorUseCase {
  final OperatorRepository  operatorRepository;

  OperatorUseCase(this.operatorRepository);

Future<OperatorEntity> execute(
      String personId, String toDate, String token) async {
    return operatorRepository.getOperatorId(
        personId, toDate, token);
  }
}

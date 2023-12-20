

import '../entity/operator_entity.dart';



abstract class OperatorRepository {
  Future<OperatorEntity> getOperatorId(
      String personId, String toDate, String token);
}
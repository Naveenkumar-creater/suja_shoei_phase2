import 'package:suja_shoie_app/feature/data/model/operator_model.dart';

abstract class OperatorDataSource {
  Future<OperatorModel> getOperatorId(
      String personId, String toDate, String token);
}

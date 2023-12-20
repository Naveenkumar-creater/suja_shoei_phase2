import 'package:suja_shoie_app/feature/domain/entity/datapoint_entity.dart';



abstract class DataPointRepository {
  Future<DataPointEntity> getDataPoints(
      int acrdId, String token);
}

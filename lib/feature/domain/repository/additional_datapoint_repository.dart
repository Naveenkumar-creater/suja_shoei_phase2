import '../entity/addtional_datapoint_entity.dart';

abstract class AdditionalDataPointRepository {
  Future<AddtionalDataPointEntity> getAdditionalDataPoint(
      String token);
}

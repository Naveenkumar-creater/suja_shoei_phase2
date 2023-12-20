
import 'package:suja_shoie_app/feature/domain/entity/datapoint_entity.dart';

import 'package:suja_shoie_app/feature/domain/repository/datapoint_repository.dart';


class DataPointUseCase {
  final DataPointRepository  dataPointRepository;

  DataPointUseCase(this.dataPointRepository);

Future<DataPointEntity> execute(
      int acrdId,  String token) async {
    return dataPointRepository.getDataPoints(
        acrdId, token);
  }
}

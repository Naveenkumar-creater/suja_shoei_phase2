import 'package:suja_shoie_app/feature/data/model/datapoint_model.dart';

abstract class DataPointDataSource {
  Future<DataPointModel> getDataPoint(
      int acrdId,String token);
}


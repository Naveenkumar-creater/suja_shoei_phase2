import 'package:suja_shoie_app/feature/data/model/datapoint_model.dart';


import '../../domain/repository/datapoint_repository.dart';
import '../data_source/Remote/remote_abstract/datapoint_data_source.dart';

class  DataPointRepositoryImpl
    implements  DataPointRepository {
  final DataPointDataSource  dataPointDataSource ;

   DataPointRepositoryImpl(this.dataPointDataSource);

  @override
  Future<DataPointModel> getDataPoints(
      int acrdId, String token) async {
DataPointModel dataPointModel  =
        await dataPointDataSource.getDataPoint(
            acrdId, token);
    return dataPointModel;
  }


}
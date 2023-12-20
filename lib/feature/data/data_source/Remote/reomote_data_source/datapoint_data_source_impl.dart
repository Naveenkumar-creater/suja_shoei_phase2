import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/datapoint_data_source.dart';

import 'package:suja_shoie_app/feature/data/model/datapoint_model.dart';

import '../../../core/datapoint_api_client.dart';

class DataPointDataSourceimpl extends DataPointDataSource {
  final DataPointClient dataPointClient;

  DataPointDataSourceimpl(this.dataPointClient);

  @override
   Future<DataPointModel> getDataPoint(int acrdId, String token) async {
    final response =  await dataPointClient.getDataPoint(acrdId,  token);

    final result = DataPointModel.fromJson(response);

    print(result);

    return result;
  }
  

}
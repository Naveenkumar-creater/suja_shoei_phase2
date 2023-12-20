import 'package:suja_shoie_app/feature/data/core/operator_api_client.dart';
import 'package:suja_shoie_app/feature/data/model/operator_model.dart';

import '../remote_abstract/operator_data_source.dart';

class OperatorDataSourceimpl extends OperatorDataSource {
  final OperatorClient operatorClient;

  OperatorDataSourceimpl(this.operatorClient);

  @override
   Future<OperatorModel> getOperatorId(String personId, String toDate, String token) async {
    final response =  await operatorClient.getDataPoint(personId, toDate, token);

    final result = OperatorModel.fromJson(response);


    return result;
  }
}
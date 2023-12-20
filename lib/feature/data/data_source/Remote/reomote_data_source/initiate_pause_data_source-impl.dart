
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/intiate_pause_datasource.dart';
import 'package:suja_shoie_app/feature/data/model/intiatepause_model.dart';

import '../../../core/intiatePause_api_client.dart';

class InitiatePauseDatasourceImpl extends InititatePauseDatasource{
final InitiatePauseClient initiatePauseClient;
InitiatePauseDatasourceImpl(
   this.initiatePauseClient
);
@override
Future<InitiatePauseModel>initiatePause(int id, String token) async{
  final response= await initiatePauseClient.initiatePause(id, token);

final result=  InitiatePauseModel.fromJson(response);

return result;

}

}
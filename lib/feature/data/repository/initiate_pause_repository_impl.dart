import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/intiate_pause_datasource.dart';
import 'package:suja_shoie_app/feature/data/model/intiatepause_model.dart';

import '../../domain/repository/initiate_pause_repository.dart';


class InitiatePauseRepositoryImpl implements InitiatePauseRepository{

  final InititatePauseDatasource intitatePauseDatasource;
InitiatePauseRepositoryImpl (this.intitatePauseDatasource);

  @override
  Future<InitiatePauseModel> initiatePause(int id, String token) async{
   final initiatepausemodel=await intitatePauseDatasource.initiatePause(id, token);
   return initiatepausemodel;
  }}
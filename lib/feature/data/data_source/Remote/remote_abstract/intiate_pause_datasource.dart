import 'package:suja_shoie_app/feature/data/model/intiatepause_model.dart';

abstract class InititatePauseDatasource{
  
  Future<InitiatePauseModel>initiatePause( int id,String token);
}
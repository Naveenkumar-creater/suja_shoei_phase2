import 'package:suja_shoie_app/feature/domain/repository/initiate_pause_repository.dart';

import '../entity/intiate_pause_entity.dart';

class InitiatePauseUsecase{
  final InitiatePauseRepository initiatePauseRepository;
  InitiatePauseUsecase(this.initiatePauseRepository);
Future<IntiatePauseEntity> execute(int id, String token){
  return initiatePauseRepository.initiatePause(id, token);

}

}
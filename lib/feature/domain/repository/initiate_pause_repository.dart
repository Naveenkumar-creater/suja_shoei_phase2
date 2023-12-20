import '../entity/intiate_pause_entity.dart';

abstract class InitiatePauseRepository{
  Future<IntiatePauseEntity>initiatePause(int id, String token);
  }
import 'package:suja_shoie_app/feature/domain/entity/check_list_entity.dart';
import 'package:suja_shoie_app/feature/domain/entity/st_submit_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/st_submit_repository.dart';

class StSubmitUsecase{
  final StSubmitRepository stSubmitrepository;
  StSubmitUsecase(this.stSubmitrepository);
  Future<StSubmitEntity> execute(Map<String,dynamic> supportTicket,String token)async{

   return await  stSubmitrepository.submitSupportTicket(supportTicket, token);

  }
}
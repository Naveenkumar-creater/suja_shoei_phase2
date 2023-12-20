import 'package:suja_shoie_app/feature/domain/entity/st_submit_entity.dart';


abstract class StSubmitRepository{
  Future<StSubmitEntity> submitSupportTicket(
      Map<String,dynamic> supportTicket, String token);
}
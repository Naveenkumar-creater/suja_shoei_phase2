import 'package:suja_shoie_app/feature/domain/entity/check_list_entity.dart';

import 'package:suja_shoie_app/feature/domain/entity/st_submit_entity.dart';

import '../../domain/repository/st_submit_repository.dart';
import '../data_source/Remote/remote_abstract/st_submit_datasource.dart';

class StSubmitRepositoryImpl implements StSubmitRepository{
  final StSubmitDataSource stSubmitDataSource;
  StSubmitRepositoryImpl(this.stSubmitDataSource);

  @override
  Future<StSubmitEntity> submitSupportTicket(Map<String,dynamic> supportTicket, String token) async{
   final result= await stSubmitDataSource.submitSupportTicket(supportTicket, token);
    return result;
  }
  

}
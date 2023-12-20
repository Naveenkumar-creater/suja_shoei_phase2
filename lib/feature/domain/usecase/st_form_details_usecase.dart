import 'package:suja_shoie_app/feature/domain/entity/st_form_entity.dart';
import '../repository/st_form_details_repository.dart';

class StFormDetailsUsecase{
  final StFormDetailsRepository stFormDetailsRepository;
 StFormDetailsUsecase(this.stFormDetailsRepository);


  Future<StFormDetailsEntity> execute (int id,String token,String todate) async{
    return await stFormDetailsRepository.getFormDetails(id,token,todate);
  }
}
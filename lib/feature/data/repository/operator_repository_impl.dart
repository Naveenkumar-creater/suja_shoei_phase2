
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/operator_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/operator_model.dart';
import 'package:suja_shoie_app/feature/domain/entity/operator_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/operator_repository.dart';

class  OperatorRepositoryImpl
    implements  OperatorRepository {
  final OperatorDataSource  operatorDataSource ;

   OperatorRepositoryImpl(this.operatorDataSource);

  @override
  Future<OperatorEntity> getOperatorId(String personId, String toDate, String token) async{
   OperatorModel operatorModel  =
        await operatorDataSource.getOperatorId(
            personId, toDate, token);
    return operatorModel;
  }


}
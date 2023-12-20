

import '../../domain/repository/additional_datapoint_repository.dart';
import '../data_source/Remote/remote_abstract/additional_datapoint_datasource.dart';
import '../model/additional_datapoint_model.dart';


class  AdditionalDataPointRepositoryImpl
    implements  AdditionalDataPointRepository {
  final AdditionalDataPointDataSource   additionalDataPointDataSource  ;

   AdditionalDataPointRepositoryImpl(this.additionalDataPointDataSource);

  @override
  Future<AdditionalDatapointModel>  getAdditionalDataPoint(
       String token) async {
AdditionalDatapointModel additionaldataPointModel  =
        await additionalDataPointDataSource.getAdditionalDataPoint(
         token);
    return additionaldataPointModel;
  }

}
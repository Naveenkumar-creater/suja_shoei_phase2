import '../../../core/Additional_datapoint_api_client.dart';
import '../../../model/additional_datapoint_model.dart';
import '../remote_abstract/additional_datapoint_datasource.dart';


class AdditionalDataPointDataSourceimpl extends AdditionalDataPointDataSource {
  final AdditionalDataPointClient additionalDataPointClient;

  AdditionalDataPointDataSourceimpl(this.additionalDataPointClient);

  @override
   Future<AdditionalDatapointModel> getAdditionalDataPoint(String token) async {
    final response =  await additionalDataPointClient.getAdditionalDataPoint(token);

    final result = AdditionalDatapointModel.fromJson(response);

    // ignore: avoid_print
    print(result);

    return result;
  }


  

}
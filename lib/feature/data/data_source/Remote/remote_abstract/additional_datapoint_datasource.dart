import '../../../model/additional_datapoint_model.dart';

abstract class AdditionalDataPointDataSource {
  Future<AdditionalDatapointModel>  getAdditionalDataPoint(
String token);
}
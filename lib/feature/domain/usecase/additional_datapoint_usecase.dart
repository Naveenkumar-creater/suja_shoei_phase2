


import '../entity/addtional_datapoint_entity.dart';
import '../repository/additional_datapoint_repository.dart';


class AdditionalDataPointUseCase  {
  final  AdditionalDataPointRepository  additionalDataPointRepository;

  AdditionalDataPointUseCase (this.additionalDataPointRepository);

Future<AddtionalDataPointEntity> execute(
   String token) async {
    return additionalDataPointRepository.getAdditionalDataPoint(
 token);
  }
}

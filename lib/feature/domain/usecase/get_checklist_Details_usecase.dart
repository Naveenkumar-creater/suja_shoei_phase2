import 'package:suja_shoie_app/feature/domain/repository/get_checklist_details_repository.dart';

import '../entity/getchecklist_details_entity.dart';

class GetCheckListdetailsUseCase {
  final GetCheckListDetailsRepository getCheckListDetailsRepository;

  GetCheckListdetailsUseCase(this.getCheckListDetailsRepository);

  Future<ChecklistDetailsEntity> execute(
      int planId, String toDate, String token, int acrpinspectionstatus) async {
    return getCheckListDetailsRepository.getCheckListDetails(
       planId, toDate, token,acrpinspectionstatus);
  }
}

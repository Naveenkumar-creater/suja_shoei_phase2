import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/get_checklist_deatils_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/get_checklist_details_model.dart';
import 'package:suja_shoie_app/feature/domain/repository/get_checklist_details_repository.dart';

class GetChecklistDetailsRepositoryImpl
    implements GetCheckListDetailsRepository {
  final GetCheckListDetailsDataSource getCheckListDetailsDataSource;

  GetChecklistDetailsRepositoryImpl(this.getCheckListDetailsDataSource);

  @override
  Future<ChecklistDetailsModel> getCheckListDetails(
      int planId, String toDate, String token,int acrpinspectionstatus) async {
    ChecklistDetailsModel checklistDetailsModel =
        await getCheckListDetailsDataSource.getCheckListDetails(
            planId, toDate, token,acrpinspectionstatus);
    return checklistDetailsModel;
  }
}

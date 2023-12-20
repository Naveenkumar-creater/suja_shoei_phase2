import '../../../model/get_checklist_details_model.dart';

abstract class GetCheckListDetailsDataSource {
  Future<ChecklistDetailsModel> getCheckListDetails(
      int planId, String toDate, String token, int acrpinspectionstatus);
}

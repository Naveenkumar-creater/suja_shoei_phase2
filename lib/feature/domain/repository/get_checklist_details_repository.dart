
import '../entity/getchecklist_details_entity.dart';


abstract class GetCheckListDetailsRepository {
  Future<ChecklistDetailsEntity> getCheckListDetails(
      int planId, String toDate, String token, int acrpinspectionstatus);
}

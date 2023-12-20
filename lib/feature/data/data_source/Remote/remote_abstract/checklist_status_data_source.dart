import 'package:suja_shoie_app/feature/data/model/checklist_status_model.dart';

abstract class CheckListStatusDataSource {
  Future<ChecklistStatusModel> getChecklistStatusCount(
      int count, String toDate, String token);
}

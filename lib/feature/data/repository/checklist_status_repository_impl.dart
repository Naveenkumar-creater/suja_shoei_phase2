import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/checklist_status_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/checklist_status_model.dart';
import 'package:suja_shoie_app/feature/domain/repository/checklist_status_count_repository.dart';

class ChecklistRepositoryImpl implements CheckListStausRepository {
  final CheckListStatusDataSource checkListDataSource;

  ChecklistRepositoryImpl(this.checkListDataSource);

  @override
  Future<ChecklistStatusModel> getChecklistStatusCount(
      int count, String toDate, String token) async {
    ChecklistStatusModel checklistStatusModel =
        await checkListDataSource.getChecklistStatusCount(count, toDate, token);
    return checklistStatusModel;
  }
}

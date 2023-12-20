import 'package:suja_shoie_app/feature/domain/entity/checklist_status_count_entity.dart';
import 'package:suja_shoie_app/feature/domain/repository/checklist_status_count_repository.dart';


class CheckListStatusCountUseCase {
  final CheckListStausRepository checkListStausRepository;

  CheckListStatusCountUseCase(this.checkListStausRepository);

  Future<ChecklistStatusEntity> execute(
      int count, String toDate, String token) async {
    return checkListStausRepository.getChecklistStatusCount(
        count, toDate, token);
  }
}

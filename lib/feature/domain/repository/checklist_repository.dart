
import '../entity/check_list_entity.dart';

abstract class CheckListRepository {
  Future<CheckListEntity> getCheckList(
      int id, String toDate, String token);
}

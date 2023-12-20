import '../../../model/check_list_model.dart';

abstract class CheckListDataSource {
  Future<CheckListModel> getCheckList(
      int id, String toDate, String token);
}

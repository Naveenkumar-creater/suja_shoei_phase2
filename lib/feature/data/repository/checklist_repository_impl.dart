import 'package:suja_shoie_app/feature/domain/repository/checklist_repository.dart';


import '../data_source/Remote/remote_abstract/checklist_data_source.dart';

import '../model/check_list_model.dart';

class ChecklistRepositoryImpl implements CheckListRepository {
  final CheckListDataSource checkListDataSource;

  ChecklistRepositoryImpl(this.checkListDataSource);

  @override
  Future<CheckListModel> getCheckList(
      int id, String toDate, String token) async {
    CheckListModel checkListModel =
        await checkListDataSource.getCheckList(id, toDate, token);
 
    return checkListModel;
  }

 
}
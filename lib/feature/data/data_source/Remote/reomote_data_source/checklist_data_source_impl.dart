import 'package:suja_shoie_app/feature/data/core/checklist_api_client.dart';
// ignore: unused_import
import 'package:suja_shoie_app/feature/data/core/checklist_status_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/checklist_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/check_list_model.dart';

class CheckListDataSourceimpl extends CheckListDataSource {
  final CheckListClient checkListClient;

  CheckListDataSourceimpl(this.checkListClient);

  @override
  Future<CheckListModel> getCheckList(
      int id, String toDate, String token) async {
  try{  final response =
        await checkListClient.getCheckList(id, toDate, token);

        if(response!=null){
          // ignore: avoid_print
          print(CheckListModel.fromJson(response));
          return CheckListModel.fromJson(response);
        }else{
          throw Exception("Response Data is Null");
        }
    
  }catch(e){
  
    rethrow;

  }

  }
}

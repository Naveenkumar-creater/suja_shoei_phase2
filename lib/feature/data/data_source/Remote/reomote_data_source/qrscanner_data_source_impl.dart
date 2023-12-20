import 'package:suja_shoie_app/feature/data/model/check_list_model.dart';

import '../../../core/qrscanner_api_client.dart';
import '../remote_abstract/qrscanner_data_aource.dart';

class QrScannerDataSourceimpl extends QrScannerDataSource {
  final QrScannerClient qrScannerClient;

  QrScannerDataSourceimpl(this.qrScannerClient);

  @override
  Future<CheckListModel> getCheckList(
   String barcode, String token) async {
  try{  final response =
        await qrScannerClient.getCheckList(barcode, token);

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

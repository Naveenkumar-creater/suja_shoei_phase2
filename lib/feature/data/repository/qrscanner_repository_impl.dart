import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/qrscanner_data_aource.dart';
import '../../domain/repository/qrscanner_repository.dart';
import '../model/check_list_model.dart';

class QrScannerRepositoryImpl implements QrScannerRepository {
  final QrScannerDataSource qrScannerDataSource;

  QrScannerRepositoryImpl(this.qrScannerDataSource);

  @override
  Future<CheckListModel> getCheckList(
       String barcode, String token) async {
    CheckListModel checkListModel =
        await qrScannerDataSource.getCheckList( barcode, token);
 
    return checkListModel;
  }

 
}
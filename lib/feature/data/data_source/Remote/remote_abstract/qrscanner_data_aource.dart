import '../../../model/check_list_model.dart';

abstract class QrScannerDataSource {
  Future<CheckListModel> getCheckList(
      String barcode, String token);
}

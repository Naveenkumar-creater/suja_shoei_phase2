
import '../entity/check_list_entity.dart';

abstract class QrScannerRepository {
  Future<CheckListEntity> getCheckList(
      String barcode, String token);
}

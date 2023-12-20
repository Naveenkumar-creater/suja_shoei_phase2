import '../../../model/st_submit_model.dart';

abstract class StSubmitDataSource {
  Future<StSubmitModel> submitSupportTicket(
      Map<String,dynamic> supportTicket, String token);
}
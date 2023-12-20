import '../../../model/loginmodel.dart';

abstract class LoginDataSource {
  Future<LoginModel> loginInUser(String loginId, String password);
}

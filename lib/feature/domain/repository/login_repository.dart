import '../entity/loginentity.dart';

abstract class LoginRepository {
  Future<loginEntity> loginInUser(String loginId, String password);
}

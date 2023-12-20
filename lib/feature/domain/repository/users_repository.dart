import '../entity/userentity.dart';

abstract class UserRepository {
  Future<UserEntity> signInUser(String email, String password);

  Future<UserEntity> getUserData(String token);
}

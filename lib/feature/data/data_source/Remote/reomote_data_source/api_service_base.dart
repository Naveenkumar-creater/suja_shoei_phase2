import '../../../model/usermodel.dart';

abstract class ApiDataSource {
  Future<UserModel> signInUser(String email, String password);
  Future<UserModel> getUserData(String token);
}

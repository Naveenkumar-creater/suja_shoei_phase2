// domain/usecase/sign_in_user_usecase_impl.dart
import 'package:suja_shoie_app/feature/domain/entity/userentity.dart';

import '../repository/users_repository.dart';

class SignInUserUseCase {
  final UserRepository userRepository;

  SignInUserUseCase(this.userRepository);

  Future<UserEntity> execute(String email, String password) async {
    return userRepository.signInUser(email, password);
  }
}

class GetUserDataUseCase {
  final UserRepository userRepository;

  GetUserDataUseCase(this.userRepository);

  Future<UserEntity> execute(String token) async {
    return userRepository.getUserData(token);
  }
}

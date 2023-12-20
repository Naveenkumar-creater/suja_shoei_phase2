import 'package:suja_shoie_app/feature/domain/entity/loginentity.dart';

import '../repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<loginEntity> execute(String loginId, String password) async {
    return loginRepository.loginInUser(loginId, password);
  }
}

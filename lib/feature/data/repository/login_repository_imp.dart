import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/login_data_source_impl.dart';
import 'package:suja_shoie_app/feature/data/model/loginmodel.dart';
import 'package:suja_shoie_app/feature/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSourceimpl loginDataSource;

  LoginRepositoryImpl(this.loginDataSource);

  @override
  Future<LoginModel> loginInUser(String loginId, String password) async {
    final loginModel = await loginDataSource.loginInUser(loginId, password);
    return loginModel;
  }
}

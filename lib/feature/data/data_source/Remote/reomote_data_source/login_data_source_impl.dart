import 'package:suja_shoie_app/feature/data/core/login_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/remote_abstract/login_data_source.dart';
import 'package:suja_shoie_app/feature/data/model/loginmodel.dart';


class LoginDataSourceimpl implements LoginDataSource {
  final LoginClient loginClient;

  LoginDataSourceimpl(this.loginClient);


  @override
  Future<LoginModel> loginInUser(String loginId, String password) async {
    final response = await loginClient.post(loginId, password);

    final result = LoginModel.fromJson(response);
    // ignore: avoid_print
    print(result);

    return result;
  }
}

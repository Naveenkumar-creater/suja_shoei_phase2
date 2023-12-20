import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suja_shoie_app/constant/utils/show_snakbar.dart';
import 'package:suja_shoie_app/feature/data/core/login_api_client.dart';
import 'package:suja_shoie_app/feature/data/data_source/Remote/reomote_data_source/login_data_source_impl.dart';
import 'package:suja_shoie_app/feature/data/repository/login_repository_imp.dart';
import 'package:suja_shoie_app/feature/domain/entity/loginentity.dart';
import 'package:suja_shoie_app/feature/presentation/pages/main_page.dart';
import 'package:suja_shoie_app/feature/presentation/pages/spalsh_page.dart';
import 'package:suja_shoie_app/feature/presentation/providers/loginprovider.dart';

import '../../domain/repository/login_repository.dart';
import '../../domain/usecase/login_usecase.dart';


class LoginApiService {
  Future<loginEntity?> login({
    required BuildContext context,
    required String loginId,
    required String password,
  }) async {
    try {
      LoginClient apiClient = LoginClient();
      LoginDataSourceimpl loginData =
          LoginDataSourceimpl(apiClient); // Use the LoginDataSourceimpl
      LoginRepository loginRepository = LoginRepositoryImpl(loginData);
      LoginUseCase loginUseCase = LoginUseCase(loginRepository);

      loginEntity loginUser = await loginUseCase.execute(loginId, password);

      // ignore: avoid_print
      print(loginUser);

      SharedPreferences pref = await SharedPreferences.getInstance();

      // ignore: use_build_context_synchronously
      Provider.of<LoginProvider>(context, listen: false).setUser(loginUser);

      await pref.setString("client_token", loginUser.clientauthToken!,);

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
        (route) => false,
      );
      return loginUser;
    } catch (e) {
      ShowError.showAlert(context, e.toString());
            rethrow;
    }
  }

  void logOutUSer(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("client_token", "");

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      ShowError.showAlert(context, e.toString());
      rethrow;
    }
  }


  // void getUserData(BuildContext context) async {
  //   try {
  //       LoginClient apiClient = LoginClient();
  //     LoginDataSourceimpl loginData =
  //         LoginDataSourceimpl(apiClient); // Use the LoginDataSourceimpl
  //     LoginRepository loginRepository = LoginRepositoryImpl(loginData);
  //     LoginUseCase loginUseCase = LoginUseCase(loginRepository);// Create the use case

  //     SharedPreferences pref = await SharedPreferences.getInstance();
  //     String? token = pref.getString("auth-token");

  //     if (token == null) {
  //       pref.setString("auth-token", "");
  //     }

  //     loginEntity user = await getUserDataUseCase.execute(token!);

  //     var userProvid = Provider.of<LoginProvider>(context, listen: false);
  //     userProvid.setUser(user);
  //   } catch (e) {
  //    ShowError.showAlert(context, e.toString());
  //   }
  // }


}



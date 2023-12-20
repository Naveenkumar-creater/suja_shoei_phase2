import 'package:flutter/material.dart';

import '../../domain/entity/userentity.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? _user;

  UserEntity? get user => _user;

  void setUser(UserEntity user) {
    _user = user;
    notifyListeners();
  }
}



//  User _user = User(
//       id: "",
//       name: "",
//       email: "",
//       password: "",
//       address: "",
//       type: "",
//       token: "",
//       machines: []);

//   User get user => _user;

//   void setUser(String user) {
//     _user = User.fromJson(user);
//     notifyListeners();
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:suja_shoie_app/feature/domain/entity/get_machine_count_entity.dart';

class GetMachineCountProvider extends ChangeNotifier{
  GetMachineCountEntity ? _user;

  GetMachineCountEntity? get user => _user;
  void setUser(GetMachineCountEntity user){
    _user=user;
    notifyListeners();

  }
}
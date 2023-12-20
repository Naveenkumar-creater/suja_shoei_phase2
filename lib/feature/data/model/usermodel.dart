import 'package:suja_shoie_app/feature/domain/entity/userentity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          address: address,
          type: type,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      type: json['type'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }
}


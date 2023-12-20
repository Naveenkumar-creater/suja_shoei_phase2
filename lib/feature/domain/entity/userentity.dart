// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? address;
  final String? type;
  final String? token;

  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.address,
    this.type,
    this.token,
  });

  @override
  List<Object?> get props {
    return [id, name, email, password, address, type, token];
  }
}

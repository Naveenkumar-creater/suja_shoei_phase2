import 'package:equatable/equatable.dart';

// ignore: camel_case_types
class loginEntity extends Equatable {
  final String? loginId;
  final String? password;
  final String? personFname;
  final String? deptName;
  final String? personLname;
  final String? orgName;
  final String? clientauthToken;
  final  int ?   orgId;
   final int ?  deptId;
   final int? personId;

  const loginEntity({
    this.loginId,
    this.password,
    this.personFname,
    this.deptName,
    this.personLname,
    this.orgName,
    this.clientauthToken,
    this.orgId,
    this.deptId,
    this.personId
  });

  @override
  List<Object?> get props => [
        loginId,
        password,
        personFname,
        deptName,
        personLname,
        orgName,
        clientauthToken,
        orgId,
       deptId,
       personId
      ];
      @override
  // TODO: implement stringify
  bool? get stringify => true;
}


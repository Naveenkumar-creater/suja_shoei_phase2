import 'package:suja_shoie_app/feature/domain/entity/loginentity.dart'; // Import your login entity class

class LoginModel extends loginEntity {
  const LoginModel({
    String? loginId,
    String? password,
    String? personFname,
    String? deptName,
    String? personLname,
    String? orgName,
    String? clientauthToken,
    int ?   orgId,
    int ?  deptId,
    int ?personId
  }) : super(
          loginId: loginId,
          password: password,
          personFname: personFname,
          deptName: deptName,
          personLname: personLname,
          orgName: orgName,
          clientauthToken: clientauthToken,
            orgId:orgId,
  deptId:deptId,
  personId: personId
        );

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final userLogin = json['response_data']['user_login'];

    return LoginModel(
      loginId: userLogin['login_id'],
      password: userLogin['login_password'],
      personFname: userLogin['person_fname'],
      deptName: userLogin['dept_name'],
      personLname: userLogin['person_lname'],
      orgName: userLogin['org_name'],
      clientauthToken: userLogin['client_aut_token'],
      orgId:userLogin['org_id'],
      deptId:userLogin['dept_id'],
      personId:userLogin['person_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login_id': loginId,
      'login_password': password,
      'person_fname': personFname,
      'dept_name': deptName,
      'person_lname': personLname,
      'org_name': orgName,
      'client_aut_token': clientauthToken,
      "org_id":orgId,
      "dept_id":deptId,
      "person_id":personId

    };
  }
}

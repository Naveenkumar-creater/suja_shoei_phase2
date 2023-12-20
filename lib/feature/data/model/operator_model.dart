
import '../../domain/entity/operator_entity.dart';

class OperatorModel extends OperatorEntity {
  const OperatorModel({
    String? personfname,
    int ? personid,
    String ?  employeeNumber,
    int ?empId
 
  
  }) : super(
   personfname
          : personfname,
          personid: personid,
   employeeNumber :employeeNumber,
    empId:empId,
        
        );


        
  factory OperatorModel.fromJson(Map<String, dynamic> json) {
    final operator = json['response_data']['Operator Details'];

    return OperatorModel(
      personfname: operator['person_fname'],
      personid: operator['person_id'],
     employeeNumber: operator['employee_number'],
      empId: operator['emp_id'],

   
    );
  }

  
}




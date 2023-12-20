import 'package:equatable/equatable.dart';

// ignore: camel_case_types
class OperatorEntity extends Equatable {
  final String? personfname;
   final int ? personid;
   final String ?  employeeNumber;
    final int ?empId;



  const OperatorEntity({
    this.personfname,
    this.personid, 
    this.employeeNumber,
    this.empId
  
  });

  @override
  List<Object?> get props => [
      personfname,
       personid,  
       employeeNumber,
       empId
       
      ];
}

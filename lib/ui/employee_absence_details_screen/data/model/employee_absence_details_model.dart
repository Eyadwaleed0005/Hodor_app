import 'package:Hodor/core/models/employee_absence_model.dart';
import 'package:Hodor/core/models/employee_model.dart';

class EmployeeAbsenceDetailsModel {
  final EmployeeModel employee;
  final List<EmployeeAbsenceModel> absences;

  const EmployeeAbsenceDetailsModel({
    required this.employee,
    required this.absences,
  });
} 
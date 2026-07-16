import 'package:Hodor/core/models/employee_model.dart';

class RecordAbsenceModel {
  final int totalEmployees;
  final int presentEmployees;
  final int absentEmployees;
  final List<RecordEmployeeItem> employees;

  const RecordAbsenceModel({
    required this.totalEmployees,
    required this.presentEmployees,
    required this.absentEmployees,
    required this.employees,
  });
}

class RecordEmployeeItem {
  final int id;
  final String name;
  final bool isPresent;

  const RecordEmployeeItem({
    required this.id,
    required this.name,
    required this.isPresent,
  });

  factory RecordEmployeeItem.fromEmployeeModel(
    EmployeeModel employee,
  ) {
    final employeeId = employee.id;

    if (employeeId == null) {
      throw StateError(
        'Employee ID cannot be null',
      );
    }

    return RecordEmployeeItem(
      id: employeeId,
      name: employee.name,
      isPresent: employee.isPresent,
    );
  }

  RecordEmployeeItem copyWith({
    int? id,
    String? name,
    bool? isPresent,
  }) {
    return RecordEmployeeItem(
      id: id ?? this.id,
      name: name ?? this.name,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
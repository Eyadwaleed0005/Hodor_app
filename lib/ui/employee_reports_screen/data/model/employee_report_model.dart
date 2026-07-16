import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/models/employee_model.dart';

class EmployeeReportModel {
  final int id;
  final String name;
  final int age;
  final double baseSalary;
  final int absentDays;
  final bool isPresent;

  const EmployeeReportModel({
    required this.id,
    required this.name,
    required this.age,
    required this.baseSalary,
    required this.absentDays,
    required this.isPresent,
  });

  factory EmployeeReportModel.fromEmployeeModel(EmployeeModel employee) {
    final employeeId = employee.id;

    if (employeeId == null) {
      throw StateError('Employee ID cannot be null');
    }

    return EmployeeReportModel(
      id: employeeId,
      name: employee.name,
      age: employee.age,
      baseSalary: employee.salary,
      absentDays: employee.absentDays,
      isPresent: employee.isPresent,
    );
  }

  int get totalMonthDays {
    return AppDateHelper.currentMonthDaysCount();
  }

  int get safeAbsentDays {
    if (absentDays < 0) {
      return 0;
    }

    if (absentDays > totalMonthDays) {
      return totalMonthDays;
    }

    return absentDays;
  }

  int get presentDays {
    return totalMonthDays - safeAbsentDays;
  }

  double get commitmentPercentage {
    if (totalMonthDays == 0) {
      return 0;
    }

    return (presentDays / totalMonthDays) * 100;
  }

  double get daySalary {
    if (totalMonthDays == 0) {
      return 0;
    }

    return baseSalary / totalMonthDays;
  }

  double get totalDeduction {
    return daySalary * safeAbsentDays;
  }

  int get suggestedSalary {
    final salaryAfterDeduction = baseSalary - totalDeduction;

    return salaryAfterDeduction.clamp(0, baseSalary).round();
  }
}

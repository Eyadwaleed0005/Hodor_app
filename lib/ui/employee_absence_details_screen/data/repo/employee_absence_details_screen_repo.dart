import 'package:Hodor/core/local/sql_lite/data_source/absence_local_data_source.dart';
import 'package:Hodor/core/local/sql_lite/data_source/employee_local_data_source.dart';
import 'package:Hodor/core/models/employee_model.dart';
import 'package:Hodor/ui/employee_absence_details_screen/data/model/employee_absence_details_model.dart';

class EmployeeAbsenceDetailsScreenRepo {
  final EmployeeLocalDataSource
      _employeeLocalDataSource;

  final AbsenceLocalDataSource
      _absenceLocalDataSource;

  EmployeeAbsenceDetailsScreenRepo({
    EmployeeLocalDataSource?
        employeeLocalDataSource,
    AbsenceLocalDataSource?
        absenceLocalDataSource,
  }) : _employeeLocalDataSource =
           employeeLocalDataSource ??
               EmployeeLocalDataSource(),
       _absenceLocalDataSource =
           absenceLocalDataSource ??
               AbsenceLocalDataSource();

  Future<EmployeeAbsenceDetailsModel>
      getEmployeeAbsenceDetails({
    required int employeeId,
  }) async {
    final monthKey = _getCurrentMonthKey();

    final employee =
        await _employeeLocalDataSource
            .getEmployeeById(
      employeeId,
    );

    if (employee == null) {
      throw const EmployeeNotFoundException();
    }

    final absences =
        await _absenceLocalDataSource
            .getEmployeeAbsenceDays(
      employeeId: employeeId,
      monthKey: monthKey,
    );

    final employeeWithCurrentMonthAbsences =
        EmployeeModel(
      id: employee.id,
      name: employee.name,
      age: employee.age,
      salary: employee.salary,
      createdAt: employee.createdAt,
      isPresent: employee.isPresent,
      absentDays: absences.length,
    );

    return EmployeeAbsenceDetailsModel(
      employee:
          employeeWithCurrentMonthAbsences,
      absences: absences,
    );
  }

  String _getCurrentMonthKey() {
    final now = DateTime.now();

    final year = now.year
        .toString()
        .padLeft(4, '0');

    final month = now.month
        .toString()
        .padLeft(2, '0');

    return '$year-$month';
  }
}

class EmployeeNotFoundException
    implements Exception {
  const EmployeeNotFoundException();
}
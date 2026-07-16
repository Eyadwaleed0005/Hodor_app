import 'package:Hodor/core/local/sql_lite/data_source/absence_local_data_source.dart';
import 'package:Hodor/core/local/sql_lite/data_source/employee_local_data_source.dart';
import 'package:Hodor/core/models/employee_absence_model.dart';
import 'package:Hodor/core/models/employee_model.dart';

class EmployeeDetailsRepository {
  final EmployeeLocalDataSource _employeeLocalDataSource;

  final AbsenceLocalDataSource _absenceLocalDataSource;

  EmployeeDetailsRepository({
    EmployeeLocalDataSource? employeeLocalDataSource,
    AbsenceLocalDataSource? absenceLocalDataSource,
  }) : _employeeLocalDataSource =
           employeeLocalDataSource ?? EmployeeLocalDataSource(),
       _absenceLocalDataSource =
           absenceLocalDataSource ?? AbsenceLocalDataSource();

  Future<List<EmployeeModel>> getEmployees() {
    return _employeeLocalDataSource.getEmployees();
  }

  Future<EmployeeModel?> getEmployeeById({required int employeeId}) {
    return _employeeLocalDataSource.getEmployeeById(employeeId);
  }

  Future<List<EmployeeAbsenceModel>> getEmployeeAbsenceDays({
    required int employeeId,
    String? monthKey,
  }) {
    return _absenceLocalDataSource.getEmployeeAbsenceDays(
      employeeId: employeeId,
      monthKey: monthKey,
    );
  }

  Future<int> deleteEmployee({required int employeeId}) {
    return _employeeLocalDataSource.deleteEmployee(employeeId);
  }
}

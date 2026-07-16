import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/local/sql_lite/data_source/absence_local_data_source.dart';
import 'package:Hodor/core/local/sql_lite/data_source/employee_local_data_source.dart';

class EmployeeDataRepository {
  final EmployeeLocalDataSource
      _employeeLocalDataSource;

  final AbsenceLocalDataSource
      _absenceLocalDataSource;

  EmployeeDataRepository({
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

  Future<int> getEmployeesCount() {
    return _employeeLocalDataSource
        .getEmployeesCount();
  }

  Future<int> getTodayAbsentCount() {
    return _absenceLocalDataSource
        .getTodayAbsentCount();
  }

  Future<int> getMonthAbsencesCount() {
    return _absenceLocalDataSource
        .getCurrentMonthAbsencesCount();
  }

  double calculateMonthlyCommitmentPercentage({
    required int employeesCount,
    required int monthAbsencesCount,
  }) {
    if (employeesCount <= 0) {
      return 0;
    }

    final currentDayNumber =
        AppDateHelper.todayDayNumber();

    final totalWorkingDays =
        employeesCount * currentDayNumber;

    if (totalWorkingDays <= 0) {
      return 0;
    }

    final presentDays =
        totalWorkingDays - monthAbsencesCount;

    final safePresentDays =
        presentDays.clamp(
      0,
      totalWorkingDays,
    );

    return (safePresentDays / totalWorkingDays)
        .clamp(0.0, 1.0)
        .toDouble();
  }
}
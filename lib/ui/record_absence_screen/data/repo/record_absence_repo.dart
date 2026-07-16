import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/core/local/sql_lite/data_source/absence_local_data_source.dart';
import 'package:Hodor/core/local/sql_lite/data_source/employee_local_data_source.dart';
import 'package:Hodor/core/models/employee_model.dart';
import 'package:Hodor/ui/record_absence_screen/data/model/record_absence_model.dart';

class RecordAbsenceRepo {
  final EmployeeLocalDataSource
      _employeeLocalDataSource;

  final AbsenceLocalDataSource
      _absenceLocalDataSource;

  RecordAbsenceRepo({
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

  Future<RecordAbsenceModel>
      getRecordAbsenceData({
    String? date,
  }) async {
    final selectedDate =
        date ??
        AppDateHelper.todayDatabaseFormat();

    final results = await Future.wait<Object>([
      _employeeLocalDataSource
          .getEmployeesCount(),
      _absenceLocalDataSource
          .getAbsentEmployeesCountByDate(
        selectedDate,
      ),
      _absenceLocalDataSource
          .getEmployeesAttendanceByDate(
        selectedDate,
      ),
    ]);

    final totalEmployees =
        results[0] as int;

    final absentEmployees =
        results[1] as int;

    final employeeModels =
        results[2] as List<EmployeeModel>;

    final presentEmployees =
        totalEmployees - absentEmployees;

    final employees = employeeModels
        .map(
          RecordEmployeeItem
              .fromEmployeeModel,
        )
        .toList();

    return RecordAbsenceModel(
      totalEmployees: totalEmployees,
      presentEmployees: presentEmployees,
      absentEmployees: absentEmployees,
      employees: employees,
    );
  }

  Future<void> registerEmployeeAbsence({
    required int employeeId,
    String? date,
  }) async {
    final selectedDate =
        date ??
        AppDateHelper.todayDatabaseFormat();

    await _absenceLocalDataSource.addAbsence(
      employeeId: employeeId,
      absenceDate: selectedDate,
    );
  }
}
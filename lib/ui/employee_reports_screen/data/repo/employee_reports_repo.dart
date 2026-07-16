import 'package:Hodor/core/local/sql_lite/data_source/employee_local_data_source.dart';
import 'package:Hodor/ui/employee_reports_screen/data/model/employee_report_model.dart';

class EmployeeReportsRepo {
  final EmployeeLocalDataSource
      _employeeLocalDataSource;

  EmployeeReportsRepo({
    EmployeeLocalDataSource?
        employeeLocalDataSource,
  }) : _employeeLocalDataSource =
           employeeLocalDataSource ??
               EmployeeLocalDataSource();

  Future<List<EmployeeReportModel>>
      getEmployeeReports() async {
    final employees =
        await _employeeLocalDataSource
            .getEmployees();

    return employees
        .map(
          EmployeeReportModel
              .fromEmployeeModel,
        )
        .toList(
          growable: false,
        );
  }

  Future<EmployeeReportModel?>
      getEmployeeReportById(
    int employeeId,
  ) async {
    final employee =
        await _employeeLocalDataSource
            .getEmployeeById(
      employeeId,
    );

    if (employee == null) {
      return null;
    }

    return EmployeeReportModel
        .fromEmployeeModel(
      employee,
    );
  }
}
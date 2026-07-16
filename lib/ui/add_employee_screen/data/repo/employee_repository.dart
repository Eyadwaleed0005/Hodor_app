import 'package:Hodor/core/models/employee_model.dart';

import '../../../../core/local/sql_lite/data_source/employee_local_data_source.dart';

class EmployeeRepository {
  final EmployeeLocalDataSource _localDataSource;

  EmployeeRepository({
    EmployeeLocalDataSource? localDataSource,
  }) : _localDataSource =
            localDataSource ?? EmployeeLocalDataSource();

  Future<int> addEmployee(
    EmployeeModel employee,
  ) async {
    return _localDataSource.addEmployee(employee);
  }

  Future<List<EmployeeModel>> getEmployees() async {
    return _localDataSource.getEmployees();
  }

  Future<EmployeeModel?> getEmployeeById(
    int employeeId,
  ) async {
    return _localDataSource.getEmployeeById(
      employeeId,
    );
  }

  Future<int> updateEmployee(
    EmployeeModel employee,
  ) async {
    return _localDataSource.updateEmployee(employee);
  }

  Future<int> deleteEmployee(
    int employeeId,
  ) async {
    return _localDataSource.deleteEmployee(
      employeeId,
    );
  }
}
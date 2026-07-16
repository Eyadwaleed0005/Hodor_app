part of 'employee_details_screen_cubit.dart';

enum EmployeeDetailsFailureType { loadEmployees, deleteEmployee }

@immutable
sealed class EmployeeDetailsScreenState {
  const EmployeeDetailsScreenState();
}

final class EmployeeDetailsScreenInitial extends EmployeeDetailsScreenState {
  const EmployeeDetailsScreenInitial();
}

final class EmployeeDetailsScreenLoading extends EmployeeDetailsScreenState {
  const EmployeeDetailsScreenLoading();
}

final class EmployeeDetailsScreenLoaded extends EmployeeDetailsScreenState {
  final List<EmployeeModel> employees;

  const EmployeeDetailsScreenLoaded({required this.employees});
}

final class EmployeeDetailsScreenEmpty extends EmployeeDetailsScreenState {
  const EmployeeDetailsScreenEmpty();
}

final class EmployeeDetailsScreenNoSearchResults
    extends EmployeeDetailsScreenState {
  const EmployeeDetailsScreenNoSearchResults();
}

final class EmployeeDetailsScreenFailure extends EmployeeDetailsScreenState {
  final EmployeeDetailsFailureType type;

  final int? employeeId;

  const EmployeeDetailsScreenFailure({required this.type, this.employeeId});
}

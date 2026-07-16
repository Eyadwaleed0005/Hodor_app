part of 'employee_reports_screen_cubit.dart';

@immutable
sealed class EmployeeReportsScreenState {
  const EmployeeReportsScreenState();
}

final class EmployeeReportsScreenInitial extends EmployeeReportsScreenState {
  const EmployeeReportsScreenInitial();
}

final class EmployeeReportsScreenLoading extends EmployeeReportsScreenState {
  const EmployeeReportsScreenLoading();
}

final class EmployeeReportsScreenSuccess extends EmployeeReportsScreenState {
  final List<EmployeeReportModel> reports;
  final bool isSearching;

  const EmployeeReportsScreenSuccess({
    required this.reports,
    required this.isSearching,
  });
}

final class EmployeeReportsScreenFailure extends EmployeeReportsScreenState {
  const EmployeeReportsScreenFailure();
}

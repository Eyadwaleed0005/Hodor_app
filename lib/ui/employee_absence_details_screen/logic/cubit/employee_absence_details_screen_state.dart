part of 'employee_absence_details_screen_cubit.dart';

@immutable
sealed class EmployeeAbsenceDetailsScreenState {
  const EmployeeAbsenceDetailsScreenState();
}

final class EmployeeAbsenceDetailsScreenInitial
    extends EmployeeAbsenceDetailsScreenState {
  const EmployeeAbsenceDetailsScreenInitial();
}

final class EmployeeAbsenceDetailsScreenLoading
    extends EmployeeAbsenceDetailsScreenState {
  const EmployeeAbsenceDetailsScreenLoading();
}

final class EmployeeAbsenceDetailsScreenSuccess
    extends EmployeeAbsenceDetailsScreenState {
  final EmployeeAbsenceDetailsModel data;

  const EmployeeAbsenceDetailsScreenSuccess({
    required this.data,
  });
}

final class EmployeeAbsenceDetailsScreenFailure
    extends EmployeeAbsenceDetailsScreenState {
  const EmployeeAbsenceDetailsScreenFailure();
}
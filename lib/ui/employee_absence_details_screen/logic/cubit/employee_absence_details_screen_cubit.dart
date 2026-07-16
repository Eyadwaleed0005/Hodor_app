import 'package:bloc/bloc.dart';
import 'package:Hodor/ui/employee_absence_details_screen/data/model/employee_absence_details_model.dart';
import 'package:Hodor/ui/employee_absence_details_screen/data/repo/employee_absence_details_screen_repo.dart';
import 'package:meta/meta.dart';

part 'employee_absence_details_screen_state.dart';

class EmployeeAbsenceDetailsScreenCubit
    extends Cubit<
        EmployeeAbsenceDetailsScreenState> {
  final EmployeeAbsenceDetailsScreenRepo
      _repo;

  EmployeeAbsenceDetailsScreenCubit({
    EmployeeAbsenceDetailsScreenRepo? repo,
  }) : _repo =
           repo ??
               EmployeeAbsenceDetailsScreenRepo(),
       super(
         const EmployeeAbsenceDetailsScreenInitial(),
       );

  Future<void> getEmployeeAbsenceDetails({
    required int employeeId,
  }) async {
    emit(
      const EmployeeAbsenceDetailsScreenLoading(),
    );

    try {
      final data =
          await _repo.getEmployeeAbsenceDetails(
        employeeId: employeeId,
      );

      emit(
        EmployeeAbsenceDetailsScreenSuccess(
          data: data,
        ),
      );
    } catch (_) {
      emit(
        const EmployeeAbsenceDetailsScreenFailure(),
      );
    }
  }
}
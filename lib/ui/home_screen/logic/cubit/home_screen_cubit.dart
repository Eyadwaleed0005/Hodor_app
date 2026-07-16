import 'package:bloc/bloc.dart';
import 'package:Hodor/core/helper/app_date_helper.dart';
import 'package:Hodor/ui/home_screen/data/repo/employee_data_repository.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final EmployeeDataRepository _repository;

  HomeScreenCubit({EmployeeDataRepository? repository})
    : _repository = repository ?? EmployeeDataRepository(),
      super(const HomeScreenInitial());

  Future<void> getHomeData() async {
    emit(const HomeScreenLoading());
    try {
      final results = await Future.wait<int>([
        _repository.getEmployeesCount(),
        _repository.getTodayAbsentCount(),
        _repository.getMonthAbsencesCount(),
      ]);

      final employeesCount = results[0];

      final todayAbsentCount = results[1];

      final monthAbsencesCount = results[2];

      final todayPresentCount = (employeesCount - todayAbsentCount)
          .clamp(0, employeesCount)
          .toInt();

      final monthlyCommitmentPercentage = _repository
          .calculateMonthlyCommitmentPercentage(
            employeesCount: employeesCount,
            monthAbsencesCount: monthAbsencesCount,
          );

      emit(
        HomeScreenLoaded(
          employeesCount: employeesCount,
          todayAbsentCount: todayAbsentCount,
          todayPresentCount: todayPresentCount,
          monthAbsencesCount: monthAbsencesCount,
          monthlyCommitmentPercentage: monthlyCommitmentPercentage,
          todayFullDate: AppDateHelper.todayFullArabicDate(),
          todayShortDate: AppDateHelper.todayDayMonthArabicDate(),
        ),
      );
    } catch (_) {
      emit(const HomeScreenFailure());
    }
  }
}

part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {
  const HomeScreenState();
}

final class HomeScreenInitial
    extends HomeScreenState {
  const HomeScreenInitial();
}

final class HomeScreenLoading
    extends HomeScreenState {
  const HomeScreenLoading();
}

final class HomeScreenLoaded
    extends HomeScreenState {
  final int employeesCount;
  final int todayAbsentCount;
  final int todayPresentCount;
  final int monthAbsencesCount;

  final double
      monthlyCommitmentPercentage;

  final String todayFullDate;
  final String todayShortDate;

  const HomeScreenLoaded({
    required this.employeesCount,
    required this.todayAbsentCount,
    required this.todayPresentCount,
    required this.monthAbsencesCount,
    required this
        .monthlyCommitmentPercentage,
    required this.todayFullDate,
    required this.todayShortDate,
  });
}

final class HomeScreenFailure
    extends HomeScreenState {
  const HomeScreenFailure();
}
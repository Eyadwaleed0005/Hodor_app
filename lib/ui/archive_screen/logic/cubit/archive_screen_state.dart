part of 'archive_screen_cubit.dart';

@immutable
sealed class ArchiveScreenState {
  const ArchiveScreenState();
}

final class ArchiveScreenInitial extends ArchiveScreenState {
  const ArchiveScreenInitial();
}

final class ArchiveScreenLoading extends ArchiveScreenState {
  const ArchiveScreenLoading();
}

final class ArchiveScreenSuccess extends ArchiveScreenState {
  final List<MonthlyArchiveModel> archives;
  final List<MonthlyArchiveModel> allArchives;

  final MonthlyArchiveModel? bestMonth;
  final MonthlyArchiveModel? worstMonth;

  final bool isSearching;

  const ArchiveScreenSuccess({
    required this.archives,
    required this.allArchives,
    required this.bestMonth,
    required this.worstMonth,
    required this.isSearching,
  });
}

final class ArchiveScreenFailure extends ArchiveScreenState {
  const ArchiveScreenFailure();
}

final class ArchiveMonthDetailsSuccess extends ArchiveScreenState {
  final MonthlyArchiveModel archive;

  final String fullMonthName;

  final List<MonthlyEmployeeArchiveModel> employees;

  const ArchiveMonthDetailsSuccess({
    required this.archive,
    required this.fullMonthName,
    required this.employees,
  });
}

final class ArchiveMonthDetailsFailure extends ArchiveScreenState {
  final MonthlyArchiveModel archive;

  const ArchiveMonthDetailsFailure({required this.archive});
}

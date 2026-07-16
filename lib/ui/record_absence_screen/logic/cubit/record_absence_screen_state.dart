part of 'record_absence_screen_cubit.dart';

@immutable
sealed class RecordAbsenceScreenDartState {
  const RecordAbsenceScreenDartState();
}

final class RecordAbsenceScreenDartInitial
    extends RecordAbsenceScreenDartState {
  const RecordAbsenceScreenDartInitial();
}

final class RecordAbsenceScreenDartLoading
    extends RecordAbsenceScreenDartState {
  const RecordAbsenceScreenDartLoading();
}

final class RecordAbsenceScreenDartSuccess
    extends RecordAbsenceScreenDartState {
  final RecordAbsenceModel data;

  final List<RecordEmployeeItem>
      filteredEmployees;

  final String searchText;

  const RecordAbsenceScreenDartSuccess({
    required this.data,
    required this.filteredEmployees,
    this.searchText = '',
  });
}

final class RecordAbsenceScreenDartFailure
    extends RecordAbsenceScreenDartState {
  final Object error;

  const RecordAbsenceScreenDartFailure({
    required this.error,
  });
}
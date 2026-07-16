import 'package:Hodor/core/local/sql_lite/data_source/archive_local_data_source.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_archive_model.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_employee_archive_model.dart';

class ArchiveRepo {
  final ArchiveLocalDataSource _localDataSource;

  ArchiveRepo({
    ArchiveLocalDataSource? localDataSource,
  }) : _localDataSource =
            localDataSource ?? ArchiveLocalDataSource();

  Future<List<MonthlyArchiveModel>> getMonthlyArchives() async {
    await _localDataSource
        .deleteArchivesBeforeFirstEmployeeMonth();

    await _localDataSource
        .autoArchivePreviousMonthIfNeeded();

    return _localDataSource.getMonthlyArchives();
  }

  Future<MonthlyArchiveModel?> getMonthlyArchiveByMonthKey(
    String monthKey,
  ) async {
    return _localDataSource.getMonthlyArchiveByMonthKey(
      monthKey,
    );
  }

  Future<List<MonthlyEmployeeArchiveModel>>
      getMonthlyEmployeeArchives(
    int archiveId,
  ) async {
    return _localDataSource.getMonthlyEmployeeArchives(
      archiveId,
    );
  }

  Future<int> archiveMonth({
    required int year,
    required int month,
  }) async {
    return _localDataSource.archiveMonth(
      year: year,
      month: month,
    );
  }
}
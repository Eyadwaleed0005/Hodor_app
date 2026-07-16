import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_archive_model.dart';
import 'package:Hodor/ui/archive_screen/data/model/monthly_employee_archive_model.dart';
import 'package:Hodor/ui/archive_screen/data/repo/archive_repo.dart';
import 'package:meta/meta.dart';

part 'archive_screen_state.dart';

class ArchiveScreenCubit extends Cubit<ArchiveScreenState> {
  ArchiveScreenCubit(this.archiveRepo) : super(const ArchiveScreenInitial());

  final ArchiveRepo archiveRepo;

  final TextEditingController searchController = TextEditingController();

  List<MonthlyArchiveModel> _allArchives = [];
  List<MonthlyArchiveModel> _filteredArchives = [];

  MonthlyArchiveModel? _bestMonth;
  MonthlyArchiveModel? _worstMonth;

  bool _isLoadingMonthDetails = false;

  Future<void> getArchiveData() async {
    emit(const ArchiveScreenLoading());

    try {
      _allArchives = await archiveRepo.getMonthlyArchives();

      _filteredArchives = List<MonthlyArchiveModel>.from(_allArchives);

      _calculateBestAndWorstMonth();

      _emitArchiveSuccess(isSearching: false);
    } catch (_) {
      emit(const ArchiveScreenFailure());
    }
  }

  void searchArchives(String value) {
    final query = value.trim().toLowerCase();

    if (query.isEmpty) {
      _filteredArchives = List<MonthlyArchiveModel>.from(_allArchives);

      _emitArchiveSuccess(isSearching: false);

      return;
    }

    _filteredArchives = _allArchives.where((archive) {
      final monthName = archive.monthName.toLowerCase();

      final monthKey = archive.monthKey.toLowerCase();

      final fullMonthName = getFullMonthName(archive).toLowerCase();

      return monthName.contains(query) ||
          monthKey.contains(query) ||
          fullMonthName.contains(query);
    }).toList();

    _emitArchiveSuccess(isSearching: true);
  }

  void clearSearch() {
    searchController.clear();
    searchArchives('');
  }

  Future<void> openArchiveDetails(MonthlyArchiveModel archive) async {
    final archiveId = archive.id;

    if (archiveId == null) {
      emit(ArchiveMonthDetailsFailure(archive: archive));

      return;
    }

    if (_isLoadingMonthDetails) {
      return;
    }

    _isLoadingMonthDetails = true;

    try {
      final employees = await archiveRepo.getMonthlyEmployeeArchives(archiveId);

      emit(
        ArchiveMonthDetailsSuccess(
          archive: archive,
          fullMonthName: getFullMonthName(archive),
          employees: employees,
        ),
      );
    } catch (_) {
      emit(ArchiveMonthDetailsFailure(archive: archive));
    } finally {
      _isLoadingMonthDetails = false;
    }
  }

  String getFullMonthName(MonthlyArchiveModel archive) {
    final parts = archive.monthKey.split('-');

    final year = parts.isNotEmpty ? parts.first : '';

    if (year.isEmpty) {
      return archive.monthName;
    }

    return '${archive.monthName} $year';
  }

  bool isBestMonth(MonthlyArchiveModel archive) {
    if (_bestMonth == null) {
      return false;
    }

    return _bestMonth!.monthKey == archive.monthKey;
  }

  bool isWorstMonth(MonthlyArchiveModel archive) {
    if (_worstMonth == null) {
      return false;
    }

    return _worstMonth!.monthKey == archive.monthKey;
  }

  void _calculateBestAndWorstMonth() {
    if (_allArchives.isEmpty) {
      _bestMonth = null;
      _worstMonth = null;
      return;
    }

    _bestMonth = _allArchives.first;
    _worstMonth = _allArchives.first;

    for (final archive in _allArchives.skip(1)) {
      if (archive.commitmentPercentage > _bestMonth!.commitmentPercentage) {
        _bestMonth = archive;
      }

      if (archive.commitmentPercentage < _worstMonth!.commitmentPercentage) {
        _worstMonth = archive;
      }
    }
  }

  void _emitArchiveSuccess({required bool isSearching}) {
    emit(
      ArchiveScreenSuccess(
        archives: List<MonthlyArchiveModel>.unmodifiable(_filteredArchives),
        allArchives: List<MonthlyArchiveModel>.unmodifiable(_allArchives),
        bestMonth: _bestMonth,
        worstMonth: _worstMonth,
        isSearching: isSearching,
      ),
    );
  }

  @override
  Future<void> close() {
    searchController.dispose();

    return super.close();
  }
}

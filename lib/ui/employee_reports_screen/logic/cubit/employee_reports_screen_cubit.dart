import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:Hodor/ui/employee_reports_screen/data/model/employee_report_model.dart';
import 'package:Hodor/ui/employee_reports_screen/data/repo/employee_reports_repo.dart';
import 'package:meta/meta.dart';

part 'employee_reports_screen_state.dart';

class EmployeeReportsScreenCubit extends Cubit<EmployeeReportsScreenState> {
  final EmployeeReportsRepo _repo;

  final TextEditingController searchController = TextEditingController();

  List<EmployeeReportModel> _allReports = [];

  EmployeeReportsScreenCubit({EmployeeReportsRepo? repo})
    : _repo = repo ?? EmployeeReportsRepo(),
      super(const EmployeeReportsScreenInitial());

  Future<void> getEmployeeReports() async {
    emit(const EmployeeReportsScreenLoading());

    try {
      final reports = await _repo.getEmployeeReports();

      _allReports = List<EmployeeReportModel>.from(reports);

      emit(
        EmployeeReportsScreenSuccess(
          reports: List<EmployeeReportModel>.unmodifiable(_allReports),
          isSearching: false,
        ),
      );
    } catch (_) {
      emit(const EmployeeReportsScreenFailure());
    }
  }

  void searchEmployeeReports(String value) {
    final query = value.trim().toLowerCase();

    if (query.isEmpty) {
      emit(
        EmployeeReportsScreenSuccess(
          reports: List<EmployeeReportModel>.unmodifiable(_allReports),
          isSearching: false,
        ),
      );

      return;
    }

    final filteredReports = _allReports.where((report) {
      final normalizedName = report.name.trim().toLowerCase();

      final employeeId = report.id.toString();

      return normalizedName.contains(query) || employeeId.contains(query);
    }).toList();

    emit(
      EmployeeReportsScreenSuccess(
        reports: List<EmployeeReportModel>.unmodifiable(filteredReports),
        isSearching: true,
      ),
    );
  }

  void clearSearch() {
    searchController.clear();
    searchEmployeeReports('');
  }

  @override
  Future<void> close() {
    searchController.dispose();

    return super.close();
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:Hodor/ui/record_absence_screen/data/model/record_absence_model.dart';
import 'package:Hodor/ui/record_absence_screen/data/repo/record_absence_repo.dart';
import 'package:meta/meta.dart';

part 'record_absence_screen_state.dart';

class RecordAbsenceScreenDartCubit extends Cubit<RecordAbsenceScreenDartState> {
  final RecordAbsenceRepo _repo;

  final TextEditingController searchController = TextEditingController();

  RecordAbsenceScreenDartCubit({RecordAbsenceRepo? repo})
    : _repo = repo ?? RecordAbsenceRepo(),
      super(const RecordAbsenceScreenDartInitial());

  RecordAbsenceModel? _data;

  Future<void> getRecordAbsenceData({String? date}) async {
    emit(const RecordAbsenceScreenDartLoading());

    try {
      final data = await _repo.getRecordAbsenceData(date: date);

      _data = data;

      _emitSuccess(
        filteredEmployees: data.employees,
        searchText: searchController.text,
      );
    } catch (error) {
      emit(RecordAbsenceScreenDartFailure(error: error));
    }
  }

  void searchEmployees(String value) {
    final data = _data;

    if (data == null) {
      return;
    }

    final query = value.trim().toLowerCase();

    final filteredEmployees = query.isEmpty
        ? List<RecordEmployeeItem>.from(data.employees)
        : data.employees.where((employee) {
            final employeeName = employee.name.trim().toLowerCase();

            final employeeId = employee.id.toString();

            return employeeName.contains(query) || employeeId.contains(query);
          }).toList();

    _emitSuccess(filteredEmployees: filteredEmployees, searchText: value);
  }

  void clearSearch() {
    searchController.clear();
    searchEmployees('');
  }

  Future<void> registerEmployeeAbsence(int employeeId, {String? date}) async {
    try {
      await _repo.registerEmployeeAbsence(employeeId: employeeId, date: date);

      await getRecordAbsenceData(date: date);
    } catch (error) {
      emit(RecordAbsenceScreenDartFailure(error: error));
    }
  }

  void _emitSuccess({
    required List<RecordEmployeeItem> filteredEmployees,
    required String searchText,
  }) {
    final data = _data;

    if (data == null) {
      return;
    }

    emit(
      RecordAbsenceScreenDartSuccess(
        data: data,
        filteredEmployees: List<RecordEmployeeItem>.unmodifiable(
          filteredEmployees,
        ),
        searchText: searchText,
      ),
    );
  }

  @override
  Future<void> close() {
    searchController.dispose();

    return super.close();
  }
}

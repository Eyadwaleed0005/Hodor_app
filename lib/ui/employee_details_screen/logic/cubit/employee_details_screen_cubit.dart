import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:Hodor/core/models/employee_model.dart';
import 'package:Hodor/ui/employee_details_screen/data/repo/employee_details_repository.dart';
import 'package:meta/meta.dart';

part 'employee_details_screen_state.dart';

class EmployeeDetailsScreenCubit extends Cubit<EmployeeDetailsScreenState> {
  final EmployeeDetailsRepository _repository;

  final TextEditingController searchController = TextEditingController();

  List<EmployeeModel> _allEmployees = [];

  EmployeeDetailsScreenCubit({EmployeeDetailsRepository? repository})
    : _repository = repository ?? EmployeeDetailsRepository(),
      super(const EmployeeDetailsScreenInitial());

  Future<void> getEmployees() async {
    emit(const EmployeeDetailsScreenLoading());

    try {
      final employees = await _repository.getEmployees();

      _allEmployees = List<EmployeeModel>.from(employees);

      _emitEmployeesForCurrentSearch();
    } catch (_) {
      emit(
        const EmployeeDetailsScreenFailure(
          type: EmployeeDetailsFailureType.loadEmployees,
        ),
      );
    }
  }

  void searchEmployees(String value) {
    _emitEmployeesForCurrentSearch();
  }

  void clearSearch() {
    searchController.clear();
    _emitEmployeesForCurrentSearch();
  }

  Future<void> deleteEmployee(int employeeId) async {
    try {
      final deletedRows = await _repository.deleteEmployee(
        employeeId: employeeId,
      );

      if (deletedRows == 0) {
        emit(
          EmployeeDetailsScreenFailure(
            type: EmployeeDetailsFailureType.deleteEmployee,
            employeeId: employeeId,
          ),
        );

        return;
      }

      _allEmployees.removeWhere((employee) => employee.id == employeeId);

      _emitEmployeesForCurrentSearch();
    } catch (_) {
      emit(
        EmployeeDetailsScreenFailure(
          type: EmployeeDetailsFailureType.deleteEmployee,
          employeeId: employeeId,
        ),
      );
    }
  }

  Future<void> retryFailure(EmployeeDetailsScreenFailure failure) async {
    switch (failure.type) {
      case EmployeeDetailsFailureType.loadEmployees:
        await getEmployees();

      case EmployeeDetailsFailureType.deleteEmployee:
        final employeeId = failure.employeeId;

        if (employeeId == null) {
          await getEmployees();
          return;
        }

        await deleteEmployee(employeeId);
    }
  }

  void _emitEmployeesForCurrentSearch() {
    if (_allEmployees.isEmpty) {
      emit(const EmployeeDetailsScreenEmpty());

      return;
    }

    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      emit(
        EmployeeDetailsScreenLoaded(
          employees: List<EmployeeModel>.unmodifiable(_allEmployees),
        ),
      );

      return;
    }

    final filteredEmployees = _allEmployees.where((employee) {
      final normalizedName = employee.name.trim().toLowerCase();

      final employeeId = employee.id?.toString() ?? '';

      return normalizedName.contains(query) || employeeId.contains(query);
    }).toList();

    if (filteredEmployees.isEmpty) {
      emit(const EmployeeDetailsScreenNoSearchResults());

      return;
    }

    emit(
      EmployeeDetailsScreenLoaded(
        employees: List<EmployeeModel>.unmodifiable(filteredEmployees),
      ),
    );
  }

  @override
  Future<void> close() {
    searchController.dispose();

    return super.close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Hodor/core/helper/app_validator.dart';
import 'package:Hodor/core/models/employee_model.dart';
import 'package:Hodor/ui/add_employee_screen/data/repo/employee_repository.dart';
import 'package:Hodor/ui/add_employee_screen/logic/add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit(this._employeeRepository) : super(const AddEmployeeState()) {
    fullNameController.addListener(_onFieldsChanged);

    ageController.addListener(_onFieldsChanged);

    salaryController.addListener(_onFieldsChanged);
  }

  final EmployeeRepository _employeeRepository;

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController salaryController = TextEditingController();

  bool _ignoreFieldChanges = false;

  void _onFieldsChanged() {
    if (_ignoreFieldChanges) {
      return;
    }

    var completedFields = 0;

    if (fullNameController.text.trim().isNotEmpty) {
      completedFields++;
    }

    if (ageController.text.trim().isNotEmpty) {
      completedFields++;
    }

    if (salaryController.text.trim().isNotEmpty) {
      completedFields++;
    }

    emit(
      state.copyWith(
        completedFields: completedFields,
        isSuccess: false,
        clearError: true,
        clearNameError: true,
        clearAgeError: true,
        clearSalaryError: true,
      ),
    );
  }

  Future<void> addEmployee() async {
    if (state.isLoading) {
      return;
    }

    final name = fullNameController.text.trim();
    final age = ageController.text.trim();
    final salary = salaryController.text.trim();

    final nameError = AppValidator.employeeName(name);

    final ageError = AppValidator.employeeAge(age);

    final salaryError = AppValidator.employeeSalary(salary);

    final hasValidationError =
        nameError != null || ageError != null || salaryError != null;

    if (hasValidationError) {
      emit(
        state.copyWith(
          nameError: nameError,
          ageError: ageError,
          salaryError: salaryError,
          isLoading: false,
          isSuccess: false,
          clearError: true,
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        clearError: true,
        clearNameError: true,
        clearAgeError: true,
        clearSalaryError: true,
      ),
    );

    try {
      final employee = EmployeeModel(
        name: name,
        age: int.parse(age),
        salary: double.parse(salary),
        createdAt: DateTime.now().toIso8601String(),
      );

      await _employeeRepository.addEmployee(employee);

      _clearControllers();

      emit(
        const AddEmployeeState(
          isLoading: false,
          isSuccess: true,
          completedFields: 0,
        ),
      );
    } catch (error) {
      debugPrint(error.toString());

      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: error,
          clearNameError: true,
          clearAgeError: true,
          clearSalaryError: true,
        ),
      );
    }
  }

  void retryAddEmployee() {
    addEmployee();
  }

  void returnToForm() {
    emit(state.copyWith(isLoading: false, isSuccess: false, clearError: true));
  }

  void prepareForAnotherEmployee() {
    _clearControllers();

    emit(const AddEmployeeState());
  }

  void _clearControllers() {
    _ignoreFieldChanges = true;

    fullNameController.clear();
    ageController.clear();
    salaryController.clear();

    _ignoreFieldChanges = false;
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    ageController.dispose();
    salaryController.dispose();

    return super.close();
  }
}

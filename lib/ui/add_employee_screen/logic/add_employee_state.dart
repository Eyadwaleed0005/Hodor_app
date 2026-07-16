class AddEmployeeState {
  final bool isLoading;
  final bool isSuccess;
  final int completedFields;

  final String? nameError;
  final String? ageError;
  final String? salaryError;

  final Object? error;

  const AddEmployeeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.completedFields = 0,
    this.nameError,
    this.ageError,
    this.salaryError,
    this.error,
  });

  bool get isFailure => error != null;

  AddEmployeeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    int? completedFields,
    String? nameError,
    String? ageError,
    String? salaryError,
    Object? error,
    bool clearNameError = false,
    bool clearAgeError = false,
    bool clearSalaryError = false,
    bool clearError = false,
  }) {
    return AddEmployeeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      completedFields: completedFields ?? this.completedFields,
      nameError: clearNameError ? null : nameError ?? this.nameError,
      ageError: clearAgeError ? null : ageError ?? this.ageError,
      salaryError: clearSalaryError ? null : salaryError ?? this.salaryError,
      error: clearError ? null : error ?? this.error,
    );
  }
}

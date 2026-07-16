class EmployeeAbsenceModel {
  final int? id;
  final int employeeId;
  final String absenceDate;
  final String createdAt;

  EmployeeAbsenceModel({
    this.id,
    required this.employeeId,
    required this.absenceDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'absenceDate': absenceDate,
      'createdAt': createdAt,
    };
  }

  factory EmployeeAbsenceModel.fromMap(Map<String, dynamic> map) {
    return EmployeeAbsenceModel(
      id: map['id'],
      employeeId: map['employeeId'],
      absenceDate: map['absenceDate'],
      createdAt: map['createdAt'],
    );
  }
}
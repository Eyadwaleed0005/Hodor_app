class MonthlyEmployeeArchiveModel {
  final int? id;
  final int archiveId;
  final int employeeId;
  final String employeeName;
  final double salary;
  final int absentDays;
  final int workDays;
  final double commitmentPercentage;
  final String createdAt;

  MonthlyEmployeeArchiveModel({
    this.id,
    required this.archiveId,
    required this.employeeId,
    required this.employeeName,
    required this.salary,
    required this.absentDays,
    required this.workDays,
    required this.commitmentPercentage,
    required this.createdAt,
  });

  factory MonthlyEmployeeArchiveModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return MonthlyEmployeeArchiveModel(
      id: map['id'],
      archiveId: map['archiveId'],
      employeeId: map['employeeId'],
      employeeName: map['employeeName'],
      salary: (map['salary'] as num).toDouble(),
      absentDays: map['absentDays'],
      workDays: map['workDays'],
      commitmentPercentage:
          (map['commitmentPercentage'] as num).toDouble(),
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'archiveId': archiveId,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'salary': salary,
      'absentDays': absentDays,
      'workDays': workDays,
      'commitmentPercentage': commitmentPercentage,
      'createdAt': createdAt,
    };
  }
}
class EmployeeModel {
  final int? id;
  final String name;
  final int age;
  final double salary;
  final String createdAt;
  final int absentDays;
  final bool isPresent;

  const EmployeeModel({
    this.id,
    required this.name,
    required this.age,
    required this.salary,
    required this.createdAt,
    this.absentDays = 0,
    this.isPresent = true,
  });

  Map<String, dynamic> toInsertMap() {
    return {
      'name': name,
      'age': age,
      'salary': salary,
      'createdAt': createdAt,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'name': name,
      'age': age,
      'salary': salary,
    };
  }

  factory EmployeeModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return EmployeeModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      age: map['age'] as int,
      salary: (map['salary'] as num).toDouble(),
      createdAt: map['createdAt'] as String,
      absentDays: (map['absentDays'] as num?)?.toInt() ?? 0,
      isPresent: (map['isPresent'] as num?)?.toInt() != 0,
    );
  }

  EmployeeModel copyWith({
    int? id,
    String? name,
    int? age,
    double? salary,
    String? createdAt,
    int? absentDays,
    bool? isPresent,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      salary: salary ?? this.salary,
      createdAt: createdAt ?? this.createdAt,
      absentDays: absentDays ?? this.absentDays,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
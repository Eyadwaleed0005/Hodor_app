import 'package:Hodor/core/helper/app_date_helper.dart';

class MonthlyArchiveModel {
  final int? id;
  final String monthKey;
  final String monthName;
  final int daysInMonth;
  final int employeesCount;
  final int totalAbsentDays;
  final double commitmentPercentage;
  final String createdAt;

  MonthlyArchiveModel({
    this.id,
    required this.monthKey,
    required this.monthName,
    required this.daysInMonth,
    required this.employeesCount,
    required this.totalAbsentDays,
    required this.commitmentPercentage,
    required this.createdAt,
  });

  factory MonthlyArchiveModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return MonthlyArchiveModel(
      id: map['id'],
      monthKey: map['monthKey'],
      monthName: map['monthName'],
      daysInMonth: map['daysInMonth'],
      employeesCount: map['employeesCount'],
      totalAbsentDays: map['totalAbsentDays'],
      commitmentPercentage:
          (map['commitmentPercentage'] as num).toDouble(),
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monthKey': monthKey,
      'monthName': monthName,
      'daysInMonth': daysInMonth,
      'employeesCount': employeesCount,
      'totalAbsentDays': totalAbsentDays,
      'commitmentPercentage': commitmentPercentage,
      'createdAt': createdAt,
    };
  }

  String get monthNameWithYear {
    return AppDateHelper.monthKeyToArabicMonthWithYear(monthKey);
  }
}
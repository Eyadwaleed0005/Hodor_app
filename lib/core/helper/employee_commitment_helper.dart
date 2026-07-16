import 'package:flutter/material.dart';
import 'package:Hodor/core/style/app_color.dart';

class EmployeeCommitmentHelper {
  EmployeeCommitmentHelper._();

  static Color getStatusColor(double percentage) {
    if (percentage >= 80) {
      return ColorPalette.green;
    }

    if (percentage >= 50) {
      return ColorPalette.yellow;
    }

    return ColorPalette.red;
  }

  static String getStatusText(double percentage) {
    if (percentage >= 80) {
      return 'ممتاز';
    }

    if (percentage >= 50) {
      return 'متوسط';
    }

    return 'ضعيف';
  }
}
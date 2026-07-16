class EmployeeNameHelper {
  EmployeeNameHelper._();

  static String getInitials(String employeeName) {
    final words = employeeName.trim().split(' ');

    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}';
    }

    return employeeName.length >= 2
        ? employeeName.substring(0, 2)
        : employeeName;
  }
}
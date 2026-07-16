class EmployeeShortNameHelper {
  EmployeeShortNameHelper._();

  static String getFirstTwoWords(String name) {
    final words = name.trim().split(RegExp(r'\s+'));

    if (words.length <= 2) {
      return name;
    }

    return '${words[0]} ${words[1]}';
  }
}
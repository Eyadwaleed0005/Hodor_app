import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    if (_prefs == null) {
      throw Exception(
        'SharedPreferencesHelper.init() must be called before using it.',
      );
    }
    return _prefs!;
  }

  // String
  static Future<void> saveString({
    required String key,
    required String value,
  }) async {
    await _instance.setString(key, value);
  }

  static String? getString({required String key}) {
    return _instance.getString(key);
  }

  // Bool
  static Future<void> saveBool({
    required String key,
    required bool value,
  }) async {
    await _instance.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    return _instance.getBool(key);
  }

  // Double
  static Future<void> saveDouble({
    required String key,
    required double value,
  }) async {
    await _instance.setDouble(key, value);
  }

  static double? getDouble({required String key}) {
    return _instance.getDouble(key);
  }

  // Remove
  static Future<void> removeData({required String key}) async {
    await _instance.remove(key);
  }

  // Contains
  static bool containsKey({required String key}) {
    return _instance.containsKey(key);
  }

  // Clear All
  static Future<void> clearAll() async {
    await _instance.clear();
  }
}

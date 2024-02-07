import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String festivalIdKey = 'festivalId';
  static const String festivalNameKey = 'festivalName';

  static Future<void> saveFestivalId(int festivalId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(festivalIdKey, festivalId);
  }

  static Future<int?> getFestivalId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(festivalIdKey);
  }

  static Future<void> saveFestivalName(String festivalName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(festivalNameKey, festivalName);
  }

  static Future<String?> getFestivalName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(festivalNameKey);
  }
}

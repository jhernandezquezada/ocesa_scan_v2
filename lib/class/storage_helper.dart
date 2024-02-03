import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String festivalIdKey = 'festivalId';

  static Future<void> saveFestivalId(int festivalId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(festivalIdKey, festivalId);
  }

  static Future<int?> getFestivalId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(festivalIdKey);
  }
}

// shared_preferences_helper.dart

import 'package:ocesa_scan_v2/widgets/festival_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _selectedFestivalIdKey = 'selectedFestivalId';
  static const String _selectedFestivalNameKey = 'selectedFestivalName';

  static Future<void> saveSelectedFestival(FestivalModel festival) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_selectedFestivalIdKey, festival.id);
    prefs.setString(_selectedFestivalNameKey, festival.name);
  }

  static Future<FestivalModel?> getSelectedFestival() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt(_selectedFestivalIdKey);
    final String? name = prefs.getString(_selectedFestivalNameKey);

    if (id != null && name != null) {
      return FestivalModel(id: id, name: name);
    } else {
      return null;
    }
  }
}

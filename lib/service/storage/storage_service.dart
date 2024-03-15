import 'package:room_rental/utils/constants/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setValue(String key, String value) async {
    final prefs = await getSharedPreferences();
    await prefs.setString(key, value);
  }

  static Future<String?> getValue(String key) async {
    final prefs = await getSharedPreferences();
    return prefs.getString(key);
  }

  static Future<void> logout() async {
    final prefs = await getSharedPreferences();
    prefs.remove(StorageKeys.accessToken);
    prefs.remove(StorageKeys.userId);
    prefs.remove(StorageKeys.profilePic);
    prefs.remove(StorageKeys.fullName);
  }

  static Future<void> setAllValue(Map<String, dynamic> values) async {
    final prefs = await getSharedPreferences();
    
    values.forEach((key, value) async {
      await prefs.setString(key, value);
    });
  }
}

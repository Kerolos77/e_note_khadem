import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> s(
      {required String key, required String value}) async {
    return await prefs.setString(key, value);
  }
  static Future<bool> putData(
      {
        required String key,
        required dynamic value,
      })async
  {
    if(value is String) return await prefs.setString(key, value);
    if(value is int) return await prefs.setInt(key, value);
    if(value is bool) return await prefs.setBool(key, value);
    return await prefs.setDouble(key, value);
  }

  static String? getData({required String key}) {
    return prefs.getString(key);
  }

  static void removeData({required String key}) {
    prefs.remove(key);
  }
}

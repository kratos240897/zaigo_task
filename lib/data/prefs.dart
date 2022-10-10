import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPrefHelper? _instance;
  factory SharedPrefHelper() => _instance ??= SharedPrefHelper._();
  SharedPrefHelper._();
  SharedPreferences? prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> set(String key, String value) async {
    await prefs!.setString(key, value);
  }

  String? get(String key) {
    return prefs!.getString(key);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<bool> containsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isKey = prefs.containsKey(key);
    return isKey;
  }

  void insertString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void insertInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  void removeAllValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String> readValueStorage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newValue = prefs.getString(value) ?? "";
    return newValue;
  }

  Future<int> readValueIntStorage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int newValue = prefs.getInt(value);
    return newValue;
  }
}

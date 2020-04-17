import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  void removeAllValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String> readValueStorage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newValue = prefs.getString(value) ?? "";
    return newValue;
  }
}

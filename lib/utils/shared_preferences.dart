import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  void setString(
    String key,
    String value,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);
  }

  Future<String> getString(
    String key,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key)!;
  }

  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // ! Geeting User Type
  void setUserTypeScr(String idkey, bool idvalue) async {
    final iduserType = await SharedPreferences.getInstance();
    await iduserType.setBool(idkey, idvalue);
  }

  Future<bool> getUserTypeScr(String idkey) async {
    final iduserType = await SharedPreferences.getInstance();
    // return iduserType.getString(idkey)!;
      return iduserType.getBool(idkey)!;
  }

  Future<bool> usercontainsKey(String idkey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(idkey);
  }
}

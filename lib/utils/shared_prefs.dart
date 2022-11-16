import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefs {
  static SharedPreferences? prefs;

  static void getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(key, value);
  }

  static getBooleanFromPrefs(String key) {
    return prefs!.getBool(key) ?? false;
  }

  static Future<bool> getBool(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(key) ?? false;
  }
  static Future<void> saveProfileData(String v) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("profileData", v);
  }

  static Future<String> getProfileData() async {
    prefs = await SharedPreferences.getInstance();

    return prefs!.getString("profileData") ?? "";
  }

  static Future<void> saveStringInPrefs(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(key, value);
  }

  static remove(String key) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove(key);
  }

  static Future clear() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.clear();
  }

  static Future<String> getString(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(key) ?? "0";
  }

  static Future<String> getLoginStatus(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(key) ?? "0";
  }

  static Future<bool> setLoginStatus(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.setString(key, value);
  }

  static Future<bool> saveObject(String key, data) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs!.setString(key, jsonEncode(data));
  }

  static Future<String> getObject(String key) async {
    return prefs!.getString(key) ?? "";
  }
  static Future<bool> savePlayerId( String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.setString("osUserID", value);
  }
}

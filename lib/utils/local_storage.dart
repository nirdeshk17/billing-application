import 'package:shared_preferences/shared_preferences.dart';

enum StorageField{
  name,
  branch,
  location,
  licenceKey,
  id,
}
class LocalStorage{

  static Future<void> setString(String? value, StorageField field) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(field.name, value ?? '');
  }

  static Future<String?> getString(StorageField field) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(field.name);
  }

  static Future<void> clearSavedData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  }
}
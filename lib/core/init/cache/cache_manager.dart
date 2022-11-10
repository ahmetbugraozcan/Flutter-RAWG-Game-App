import 'package:appcentflutterassignment/core/constants/enums/preferences_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._init();

  SharedPreferences? _preferences;
  static CacheManager get instance => _instance;

  CacheManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static Future preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> removeKey(PreferencesEnums key) async {
    await instance._preferences!.remove(key.name.toString());
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> clearAllSaveFirst() async {
    if (_preferences != null) {
      await _preferences!.clear();
      await setBoolValue(PreferencesEnums.IS_FIRST_APP, true);
    }
  }

  Future<void> setStringValue(PreferencesEnums key, String value) async {
    await _preferences!.setString(key.name.toString(), value);
  }

  Future<void> setIntValue(PreferencesEnums key, int value) async {
    await _preferences!.setInt(key.name.toString(), value);
  }

  Future<void> setBoolValue(PreferencesEnums key, bool value) async {
    await _preferences!.setBool(key.name.toString(), value);
  }

  Future<void> setStringList(PreferencesEnums key, List<String> value) async {
    await _preferences!.setStringList(key.name.toString(), value);
  }

  List<String>? getStringListValue(PreferencesEnums key) =>
      _preferences?.getStringList(key.name.toString());

  String? getStringValue(PreferencesEnums key) =>
      _preferences?.getString(key.name.toString());

  int? getIntValue(PreferencesEnums key) =>
      _preferences?.getInt(key.name.toString());

  bool getBoolValue(PreferencesEnums key) =>
      _preferences!.getBool(key.name.toString()) ?? false;

  bool containsKey(PreferencesEnums key) =>
      _preferences!.containsKey(key.name.toString());
}

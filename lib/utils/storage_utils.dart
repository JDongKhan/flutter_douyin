import 'dart:async';
import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

/// @author jd
/// SharedPreferences Util.
class StorageUtil {
  static StorageUtil? _singleton;
  static SharedPreferences? _prefs;

  /// 初始化必备操作 eg:user数据
  static LocalStorage? localStorage;
  static final Lock _lock = Lock();
  static String? unique_identification;

  static Future<StorageUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = StorageUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton!;
  }

  StorageUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    return await localStorage?.ready;
  }

  /// put object.
  static Future<bool> putObject(String key, Object? value) async {
    if (_prefs == null) return false;
    return await _prefs!
        .setString(key, value == null ? "" : json.encode(value));
  }

  /// get obj.
  static T getObj<T>(String key, T Function(Map? v) f, {required T defValue}) {
    Map? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  /// get object.
  static Map? getObject(String key) {
    if (_prefs == null) return null;
    String? data = _prefs?.getString(key);
    if (data == null || data.isEmpty) {
      return null;
    } else {
      return json.decode(data) as Map;
    }
  }

  /// put object list.
  static Future<bool> putObjectList(String key, List<Object>? list) async {
    if (_prefs == null) return false;
    List<String>? dataList = list?.map((value) {
      return json.encode(value);
    })?.toList();
    if (dataList == null) return false;
    return await _prefs!.setStringList(key, dataList);
  }

  /// get obj list.
  static List<T> getObjList<T>(String key, T f(Map? v),
      {List<T> defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    })?.toList();
    return list ?? defValue;
  }

  /// get object list.
  static List<Map>? getObjectList(String key) {
    if (_prefs == null) return null;
    List<String>? dataLis = _prefs?.getStringList(key);
    if (dataLis == null) {
      return null;
    }
    return dataLis.map((value) {
      Map dataMap = json.decode(value) as Map;
      return dataMap;
    }).toList();
  }

  /// get string.
  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs!.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool> putString(String key, String value) async {
    if (_prefs == null) return false;
    return await _prefs!.setString(key, value);
  }

  /// get bool.
  static bool getBool(String key, {bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs!.getBool(key) ?? defValue;
  }

  /// put bool.
  static Future<bool> putBool(String key, bool value) async {
    if (_prefs == null) return false;
    return await _prefs!.setBool(key, value);
  }

  /// get int.
  static int getInt(String key, {int defValue = 0}) {
    if (_prefs == null) return defValue;
    return _prefs!.getInt(key) ?? defValue;
  }

  /// put int.
  static Future<bool> putInt(String key, int value) async {
    if (_prefs == null) return false;
    return await _prefs!.setInt(key, value);
  }

  /// get double.
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_prefs == null) return defValue;
    return _prefs!.getDouble(key) ?? defValue;
  }

  /// put double.
  static Future<bool> putDouble(String key, double value) async {
    if (_prefs == null) return false;
    return await _prefs!.setDouble(key, value);
  }

  /// get string list.
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    if (_prefs == null) return defValue;
    return _prefs!.getStringList(key) ?? defValue;
  }

  /// put string list.
  static Future<bool> putStringList(String key, List<String> value) async {
    if (_prefs == null) return false;
    return await _prefs!.setStringList(key, value);
  }

  /// get dynamic.
  static dynamic getDynamic(String key, {dynamic defValue}) {
    if (_prefs == null) return defValue;
    return _prefs!.get(key) ?? defValue;
  }

  /// have key.
  static bool haveKey(String key) {
    if (_prefs == null) return false;
    return _prefs!.getKeys().contains(key);
  }

  /// get keys.
  static Set<String>? getKeys() {
    if (_prefs == null) return null;
    return _prefs!.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) async {
    if (_prefs == null) return false;
    return await _prefs!.remove(key);
  }

  /// clear.
  static Future<bool> clear() async {
    if (_prefs == null) return false;
    return await _prefs!.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _prefs != null;
  }
}

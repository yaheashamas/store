import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //set all type
  static Future<bool> setData({
    required final String key,
    required final dynamic value,
  }) async {
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return await sharedPreferences.setBool(key, value);
  }

  //get bool
  static bool? getBool({
    required final String key,
  }) {
    return sharedPreferences.getBool(key);
  }

  //get string
  static String? getString({
    required final String key,
  }) {
    return sharedPreferences.getString(key);
  }

  //delete
  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}

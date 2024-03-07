import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'config.dart';
import 'main.dart';
class MyTheme with ChangeNotifier{
  static bool _isDark = false;
  ThemeMode currentTheme(){
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }
  bool switchTheme(){
    if (_isDark == false){
    _isDark = true;
    notifyListeners();
    return true;}
    else{
      _isDark = false;
      notifyListeners();
    return false;}

  }
}
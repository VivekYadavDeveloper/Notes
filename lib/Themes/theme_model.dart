import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//*** First We Create Class For Themes
//**! @VivekYadavDev Github Account.
//*** Now Create a Instance of Theme
//*** Then Create a Boolean Function of "Theme Model" To Know That Which Theme is Now.
//*** Create a Getter of _currentTheme.

///? Now Create ToggleTheme Function with async Method to Call The Theme
//*** Create Share-Preferences Instance.

class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();

  ThemeModel(bool isDark) {
    if (isDark) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
  }
  ThemeData get currentTheme => _currentTheme;
  void toggleTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (_currentTheme == ThemeData.light()) {
      _currentTheme = ThemeData.dark();
      sharedPreferences.setBool('isDark', true);
    } else {
      _currentTheme = ThemeData.light();
      sharedPreferences.setBool('isDark', false);
    }
    notifyListeners();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

//*** Create a Class of Share Preferences.
//*** Create Static const Preferences Key.
//**! @VivekYadavDev Github Account.
//*** Now Create setTheme Boolean Function With Async to Set The Theme.

class ThemeSharePreferences {
  static const PREF_KEY = "preferences";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}

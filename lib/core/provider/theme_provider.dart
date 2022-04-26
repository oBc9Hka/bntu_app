import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/material_themes.dart';

enum CustomBrightness { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = themeLight;
  CustomBrightness _brightness = CustomBrightness.light;
  Icon _currentIcon = Icon(Icons.toggle_off_outlined);

  ThemeData get current => _currentTheme;

  CustomBrightness get brightness => _brightness;

  Icon get currentIcon => _currentIcon;

  ThemeProvider(String theme) {
    if (theme == 'dark') {
      _brightness = CustomBrightness.dark;
      _currentTheme = themeDark;
      _currentIcon = Icon(Icons.toggle_on);
    } else {
      _brightness = CustomBrightness.light;
      _currentTheme = themeLight;
      _currentIcon = Icon(Icons.toggle_off_outlined);
    }
  }

  void toggle(CustomBrightness brightness) async {
    if (brightness == CustomBrightness.dark) {
      _brightness = CustomBrightness.dark;
      _currentTheme = themeDark;
      _currentIcon = Icon(Icons.toggle_on);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme', 'dark');
    } else {
      _brightness = CustomBrightness.light;
      _currentTheme = themeLight;
      _currentIcon = Icon(Icons.toggle_off_outlined);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme', 'light');
    }
    notifyListeners();
  }
}

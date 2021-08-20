import 'package:bntu_app/themes/material_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CustomBrightness {light, dark}


class ThemeProvider extends ChangeNotifier{
  ThemeData _currentTheme = themeLight;
  CustomBrightness _brightness = CustomBrightness.light;
  Icon _currentIcon = Icon(Icons.toggle_off_outlined);

  ThemeData get current => _currentTheme;
  CustomBrightness get brightness => _brightness;
  Icon get currentIcon => _currentIcon;

  toggle(CustomBrightness brightness){
    if(brightness == CustomBrightness.dark){
      _brightness = CustomBrightness.dark;
      _currentTheme = themeDark;
      _currentIcon = Icon(Icons.toggle_on);
    } else{
      _brightness = CustomBrightness.light;
      _currentTheme = themeLight;
      _currentIcon = Icon(Icons.toggle_off_outlined);
    }
    notifyListeners();
  }
}
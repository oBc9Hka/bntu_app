// @dart=2.9

import 'package:bntu_app/pages/main_page.dart';
import 'package:bntu_app/pages/map.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:bntu_app/pages/greeting_screen.dart';
import 'package:bntu_app/pages/info.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:provider/provider.dart';
// import 'package:splashscreen/splashscreen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        child: App(),
      ),
    );

class App extends StatelessWidget {
  const App ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: CustomSplash(
        imagePath: 'assets/bntu.png',
        duration: 3000,
        home: GreetingScreen(),
        type: CustomSplashType.StaticDuration,
        backGroundColor: Colors.white,
        animationEffect: 'fade-in',
        logoSize: 225,
      ),
      theme: themeProvider.current,
      routes: {
        // '/': (context) => GreetingScreen(),
        '/main_page': (context) => MainPage(title: 'MainPage'),
        '/info': (context) => Info(),
        '/map': (context) => BuildingsMap(),
      },
    );
  }
}

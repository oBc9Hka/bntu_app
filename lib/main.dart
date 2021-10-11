// @dart=2.9

import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/repository/buildings_repository.dart';
import 'package:bntu_app/repository/error_messages_repository.dart';
import 'package:bntu_app/repository/faculties_repository.dart';
import 'package:bntu_app/repository/info_cards_repository.dart';
import 'package:bntu_app/repository/settings_repository.dart';
import 'package:bntu_app/repository/specialties_repository.dart';
import 'package:bntu_app/ui/pages/admission_info/info.dart';
import 'package:bntu_app/ui/pages/faculties_views/main_page.dart';
import 'package:bntu_app/ui/pages/greeting_screen.dart';
import 'package:bntu_app/ui/pages/map_view/map.dart';
import 'package:bntu_app/ui/pages/messages_page.dart';
import 'package:bntu_app/ui/pages/quizz_view/main_menu.dart';
import 'package:bntu_app/ui/pages/quizz_view/quiz_list.dart';
import 'package:bntu_app/ui/pages/settings_page.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final theme = prefs.getString('theme') ?? 'light';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(theme)),
        ChangeNotifierProvider(
            create: (context) => AppProvider(
                  FacultiesFirestoreRepository(),
                  SpecialtiesFirestoreRepository(),
                  SettingsFirestoreRepository(),
                  InfoCardsFirestoreRepository(),
                  ErrorMessagesFirestoreRepository(),
                  BuildingsFirestoreRepository(),
                )),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: CustomSplash(
        imagePath: themeProvider.brightness == CustomBrightness.dark
            ? 'assets/bntu_logo_dark.png'
            : 'assets/bntu_logo.png',
        duration: 2500,
        home: GreetingScreen(),
        type: CustomSplashType.StaticDuration,
        backGroundColor: themeProvider.brightness == CustomBrightness.dark
            ? Color.fromARGB(255, 17, 17, 17)
            : Colors.white,
        animationEffect: 'fade-in',
        logoSize: 225,
      ),
      theme: themeProvider.current,
      routes: {
        '/main_page': (context) => MainPage(),
        '/settings': (context) => SettingsPage(),
        '/messages': (context) => MessagesPage(),
        '/info': (context) => Info(),
        '/map': (context) => BuildingsMap(),
        '/test': (context) => MainMenu(),
        '/testList': (context) => QuizList(),
      },
    );
  }
}

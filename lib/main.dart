// @dart=2.9

import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/core/repository/error_messages_repository.dart';
import 'package:bntu_app/features/faculties/ui/faculties_screen.dart';
import 'package:bntu_app/features/greetings/ui/greeting_screen.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:bntu_app/features/quiz/repository/quiz_repository.dart';
import 'package:bntu_app/features/settings/repository/settings_repository.dart';
import 'package:bntu_app/features/settings/ui/messages_page.dart';
import 'package:bntu_app/features/quiz/ui/quiz_main_menu.dart';
import 'package:bntu_app/features/settings/ui/settings_page.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/provider/app_provider.dart';
import 'core/repository/user_repository.dart';
import 'features/admission_info/provider/admission_info_provider.dart';
import 'features/admission_info/repository/info_cards_repository.dart';
import 'features/admission_info/ui/info.dart';
import 'features/faculties/provider/faculties_provider.dart';
import 'features/faculties/repository/faculties_repository.dart';
import 'features/greetings/provider/greetings_provider.dart';
import 'features/map/provider/map_provider.dart';
import 'features/map/repository/buildings_repository.dart';
import 'features/map/ui/map.dart';
import 'features/settings/provider/settings_provider.dart';
import 'features/specialties/provider/specialties_provider.dart';
import 'features/specialties/repository/specialties_repository.dart';

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
            userRepository: UserFirestoreRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => GreetingsProvider(
            errorMessagesRepository: ErrorMessagesFirestoreRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FacultiesProvider(
            facultiesRepository: FacultiesFirestoreRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SpecialtiesProvider(
            specialtiesRepository: SpecialtiesFirestoreRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AdmissionInfoProvider(
            infoCardsRepository: InfoCardsFirestoreRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(
            settingsRepository: SettingsFirestoreRepository(),
            errorMessagesRepository: ErrorMessagesFirestoreRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => MapProvider(
            buildingsRepository: BuildingsFirestoreRepository(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => QuizProvider(
            quizRepository: QuizFirestoreRepository(),
          ),
        ),
      ],
      child: BntuApp(),
    ),
  );
}

class BntuApp extends StatelessWidget {
  const BntuApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: CustomSplash(
        imagePath: themeProvider.brightness == CustomBrightness.dark
            ? 'assets/bntu_logo_dark.png'
            : 'assets/BNTU_Logo.png',
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
        '/main_page': (context) => FacultiesScreen(),
        '/settings': (context) => SettingsPage(),
        '/messages': (context) => MessagesPage(),
        '/info': (context) => Info(),
        '/map': (context) => BuildingsMap(),
      },
    );
  }
}

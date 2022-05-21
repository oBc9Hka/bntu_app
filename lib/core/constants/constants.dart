import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../features/quiz/domain/models/quiz_result.dart';

class Constants {
  static const Color mainColor = Color.fromARGB(255, 0, 138, 94);

  static Point initialPoint = Point(
    latitude: 53.922288,
    longitude: 27.593033,
  );

  static const url = 'https://bntu.by';

  static ButtonStyle customElevatedButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: mainColor),
      ),
    ),
  );

  static List<String> quizSpecAnswersList = ['..', 'D', 'I', 'S', 'C'];
  static List<int> quizFacAnswersList = [1, 2, 3, 4, 5, 6, 7, 8];

  static List<QuizResult> quizResultList = [
    QuizResult(letter: 'D', specialties: [
      {'Менеджер-экономист': 'ФТУГ'},
      {'Маркетолог-экономист': 'ФММП'},
      {'Менеджер по продажам': 'ФММП'},
      {'Логист': 'ФММП'},
    ]),
    QuizResult(letter: 'I', specialties: [
      {'Педагог-инженер': 'ИПФ'},
      {'Экономист': 'ФММП'},
      {'Архитектор-дизайнер': 'АФ'},
      {'Инеженер-конструктор-дизайнер': 'ФТУГ'},
    ]),
    QuizResult(letter: 'S', specialties: [
      {'Инженер-экономист': 'АТФ'},
      {'Инженер-экономист': 'МСФ'},
      {'Инженер-программист': 'ФИТР'},
    ]),
    QuizResult(letter: 'C', specialties: [
      {'Инженер-электромеханик': 'ПСФ'},
      {'Инженер-технолог': 'ФГДЭ'},
      {'Горный инженер': 'ФГДЭ'},
      {'Инженер-энергетик': 'ЭФ'},
      {'Инженер-строитель': 'ФЭС'},
      {'Инженер-строитель': 'СФ'},
      {'Инженер-программист': 'ФИТР'},
      {'Инженер': 'МТФ'},
      {'Инженер': 'ФТК'},
      {'Инженер': 'СТФ'},
    ]),
  ];
}

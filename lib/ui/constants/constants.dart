import 'package:bntu_app/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../models/quiz_result.dart';

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

  static List<String> quizSpecAnswersList = ['..','D', 'I', 'S', 'C'];
  static List<int> quizFacAnswersList = [1, 2, 3, 4, 5, 6, 7, 8];

  static List<QuestionModel> quizQuestionsList = [
    QuestionModel(
        id: 'qwe',
        orderId: 1,
        question:
            'Вы пришли в гости, где собрались уже более 10 человек. Ваша реакция: ',
        answers: [
          {
            'Обожаю шумные компании: можно повеселиться, обрести новых знакомых.':
                ['I']
          },
          {
            'Я люблю бывать в компаниях, часто оказываюсь в центре внимания. Удастся хорошенько зажечь, или, на худой конец, с полезными людьми познакомлюсь.':
                ['D']
          },
          {
            'Надеюсь, что встречу каких-нибудь знакомых, мне будет приятно и комфортно с ними пообщаться.':
                ['S']
          },
          {
            'Я не очень люблю шумные компании и хожу на вечеринки только, чтобы завести или поддержать полезные знакомства.':
                ['C']
          },
        ]),
    QuestionModel(
        id: 'asd',
        orderId: 2,
        question: 'Что для Вас является главным в победе, достижении успеха: ',
        answers: [
          {
            'Личные усилия человека, выкладывающегося по максимуму, не прячущегося за спинами других.':
                ['D', 'C']
          },
          {
            'Командная работа, люди могут добиться чего-либо только вместе.': [
              'S',
              'I'
            ]
          },
        ]),
  ];

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

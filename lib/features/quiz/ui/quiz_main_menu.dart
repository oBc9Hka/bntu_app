import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import 'quiz_screen.dart';

class QuizMainMenu extends StatelessWidget {
  const QuizMainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _getQuestionsWord(int length) {
      return length == 1
          ? 'вопрос'
          : length < 5
              ? 'вопроса'
              : 'вопросов';
    }

    var height = MediaQuery.of(context).size.height;
    var mainColor = Constants.mainColor;
    var themeProvider = Provider.of<ThemeProvider>(context);

    final quizState = context.watch<QuizProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Тест'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48.0,
          horizontal: 12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: height / 3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(
                          (themeProvider.brightness == CustomBrightness.light)
                              ? 'assets/BNTU_Logo.png'
                              : 'assets/bntu_logo_dark.png')
                      .image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  quizState.activeQuiz?.quizDescription ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'Тест содержит ${quizState.activeQuiz!.questions.length} ${_getQuestionsWord(quizState.activeQuiz!.questions.length)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                  style: Constants.customElevatedButtonStyle,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      'Начать тест',
                      style: TextStyle(
                        fontSize: 26.0,
                        // color: mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

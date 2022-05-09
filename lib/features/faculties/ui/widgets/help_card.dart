import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constants.dart';
import '../../../quiz/provider/quiz_provider.dart';
import '../../../quiz/ui/quiz_main_menu.dart';
import '../../../settings/provider/settings_provider.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showLoadingDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: LinearProgressIndicator(
              color: Constants.mainColor,
            ),
          );
        },
      );
    }

    final settingsState = context.watch<SettingsProvider>();
    final quizState = context.watch<QuizProvider>();
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Constants.mainColor),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Не можешь выбрать специальность?',
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.youtube_searched_for,
                size: 36,
                color: Constants.mainColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text('Пройди тест, который поможет тебе в этом!'),
            ),
            ElevatedButton(
              onPressed: () async {
                _showLoadingDialog();
                await settingsState.initSettings();
                await quizState.getQuizList(quizIds: settingsState.quizIds);
                Navigator.of(context).pop();
                if (settingsState.quizIds.length == 1) {
                  await quizState.setActiveQuiz(
                    docId: settingsState.quizIds.first,
                    quizIds: settingsState.quizIds,
                  );

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizMainMenu(),
                    ),
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: settingsState.quizIds.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/sad_icon.svg',
                                      color: Constants.mainColor,
                                      height: 50,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Text(
                                          'Доступных к прохождению тестов пока нет',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Выбор теста',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: [
                                      for (var i = 0;
                                          i < settingsState.quizIds.length;
                                          i++)
                                        ListTile(
                                          title: Text(
                                            quizState.quizList
                                                .firstWhere((element) =>
                                                    element!.docId ==
                                                    settingsState.quizIds[i])!
                                                .quizName,
                                          ),
                                          onTap: () {
                                            quizState.setActiveQuiz(
                                              docId: settingsState.quizIds[i],
                                              quizIds: settingsState.quizIds,
                                            );

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    QuizMainMenu(),
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                  )
                                ],
                              ),
                      );
                    },
                  );
                }
              },
              style: Constants.customElevatedButtonStyle,
              child: Text(
                'Пройти тест',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

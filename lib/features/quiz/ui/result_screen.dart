import 'package:auto_size_text/auto_size_text.dart';
import 'package:bntu_app/features/greetings/ui/greeting_screen.dart';
import 'package:bntu_app/features/quiz/domain/models/answer_model.dart';
import 'package:bntu_app/features/quiz/domain/models/coeff_model.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:bntu_app/features/specialties/ui/specialties_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../features/faculties/domain/models/faculty_model.dart';
import '../../faculties/provider/faculties_provider.dart';
import 'quiz_main_menu.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.answersList,
  }) : super(key: key);
  final List<Answer> answersList;

  @override
  Widget build(BuildContext context) {
    var _fit = '...';
    var _mayFit = '...';
    var _mayFitVisibility = false;
    var maxWeightCoeffName = '';

    final coeffList = <Coeff>[];

    for (var i = 0; i < answersList.length; i++) {
      for (var j = 0; j < answersList[i].coefficients.length; j++) {
        try {
          final el = coeffList.firstWhere(
              (element) => element.key == answersList[i].coefficients[j].key);
          final index = coeffList.indexOf(el);
          coeffList[index] = coeffList[index].copyWith(
            weight:
                answersList[i].coefficients[j].weight + coeffList[index].weight,
          );
        } catch (e) {
          coeffList.add(answersList[i].coefficients[j]);
        }
      }
    }
    print('UNSORTED: $coeffList');

    coeffList.sort(
      (a, b) => b.weight.compareTo(a.weight),
    );
    print('SORTED: $coeffList');
    final maxWeight = coeffList.first.weight;

    Faculty _getFacultyByShortName(String name, List<Faculty> list) {
      for (var faculty in list) {
        if (faculty.shortName?.toLowerCase() == name.toLowerCase()) {
          return faculty;
        }
      }
      throw 'Факультет не найден';
    }

    _fit = 'Тебе больше всего подходят:';

    var fixedExtentScrollController = FixedExtentScrollController();
    const mainColor = Constants.mainColor;

    final facultyState = context.watch<FacultiesProvider>();
    return Consumer<QuizProvider>(builder: (context, state, child) {
      var mayFitFacultyList = <Coeff>[];
      var mayFitFacultyIndex = 0;
      for (var item in coeffList) {
        if (item.weight < maxWeight) {
          mayFitFacultyList.add(item);
          _mayFit = 'Так же тебе могут подойти:';
          _mayFitVisibility = true;
        }
      }

      if (state.activeQuiz!.needPrintResults) {
        maxWeightCoeffName =
            coeffList.firstWhere((element) => element.weight == maxWeight).key;
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Результаты'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Результат теста',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  AutoSizeText(
                    _fit,
                    maxLines: 1,
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !state.activeQuiz!.needPrintResults
                      ? Column(
                          children: [
                            Column(
                              children: [
                                for (var item in coeffList)
                                  if (item.weight == maxWeight)
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialtiesScreen(
                                              faculty: _getFacultyByShortName(
                                                item.key,
                                                facultyState.faculties,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        item.key.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 26, color: mainColor),
                                      ),
                                    ),
                              ],
                            ),
                            Visibility(
                              visible: _mayFitVisibility,
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    _mayFit,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 50,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.3),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialtiesScreen(
                                              faculty: _getFacultyByShortName(
                                                mayFitFacultyList[
                                                        mayFitFacultyIndex]
                                                    .key,
                                                facultyState.faculties,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ListWheelScrollView(
                                        controller: fixedExtentScrollController,
                                        physics: FixedExtentScrollPhysics(),
                                        itemExtent: 60.0,
                                        diameterRatio: 2,
                                        squeeze: 1,
                                        perspective: 0.01,
                                        onSelectedItemChanged: (index) {
                                          mayFitFacultyIndex = index;
                                        },
                                        children: [
                                          for (var item in mayFitFacultyList)
                                            Container(
                                              constraints: BoxConstraints(
                                                minWidth: 100,
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SpecialtiesScreen(
                                                        faculty:
                                                            _getFacultyByShortName(
                                                          item.key,
                                                          facultyState
                                                              .faculties,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  item.key,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.5,
                          ),
                          child: ListView(
                            children: [
                              for (var item in state.activeQuiz!.coeffResults
                                  .firstWhere((element) =>
                                      element.name == maxWeightCoeffName)
                                  .results)
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SpecialtiesScreen(
                                          faculty: _getFacultyByShortName(
                                            item.faculty,
                                            facultyState.faculties,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(item.speciality),
                                  trailing: Text(item.faculty),
                                )
                            ],
                          ),
                        ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizMainMenu(),
                        ),
                      );
                    },
                    style: Constants.customElevatedButtonStyle,
                    child: Text(
                      'Пройти тест заново',
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 10)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GreetingScreen(),
                          ));
                    },
                    style: Constants.customElevatedButtonStyle,
                    child: Text(
                      'Вернуться на главную',
                      style: TextStyle(color: mainColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

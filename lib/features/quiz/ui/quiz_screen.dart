import 'package:auto_size_text/auto_size_text.dart';
import 'package:bntu_app/features/quiz/domain/models/answer_model.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/enums/question__types.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool btnPressed = false;
  PageController? _controller;
  String btnText = 'Следующий вопрос';
  bool answered = false;
  bool showMsg = false;
  int groupValue = 0;
  List<AnswerTileModel> answersTiles = [];

  List<Answer> answers = [];
  bool isLoading = false;
  String errorMsg = '';

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  bool isInited = false;

  @override
  Widget build(BuildContext context) {
    const mainColor = Constants.mainColor;
    return Consumer<QuizProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Профориентационный тест'),
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                )
              : Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: PageView.builder(
                      controller: _controller!,
                      onPageChanged: (page) {
                        if (state.activeQuiz!.questions.isNotEmpty) {
                          if (page == state.activeQuiz!.questions.length - 1) {
                            setState(() {
                              btnText = 'Увидеть результат';
                            });
                          }
                        }
                        setState(() {
                          answered = false;
                        });
                      },
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.activeQuiz!.questions.length,
                      itemBuilder: (context, index) {
                        return body(state, index);
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget body(QuizProvider state, int index) {
    if (state.activeQuiz!.questions[index].questionType ==
        QuestionTypes.multiple_answers) {
      for (var i = 0;
          i < state.activeQuiz!.questions[index].answers.length;
          i++) {
        answersTiles.add(AnswerTileModel(
          id: i,
          isChecked: false,
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Вопрос ${index + 1}/${state.activeQuiz!.questions.length}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 28.0,
                  ),
                ),
              ),
              Divider(
                color: Constants.mainColor,
              ),
              Visibility(
                visible: showMsg,
                child: Text(
                  'Необходимо выбрать один вариант ответа',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.25,
                  ),
                  child: AutoSizeText(
                    state.activeQuiz!.questions[index].question,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (int i = 1;
                          i <=
                              state.activeQuiz!.questions[index].answers.length;
                          i++)
                        state.activeQuiz!.questions[index].questionType ==
                                QuestionTypes.single_answer
                            ? RadioListTile(
                                activeColor: Constants.mainColor,
                                title: Text(
                                  state.activeQuiz!.questions[index]
                                      .answers[i - 1].text,
                                ),
                                value: i,
                                groupValue: groupValue,
                                onChanged: (T) {
                                  setState(() {
                                    groupValue = T as int;
                                  });
                                },
                              )
                            : CheckboxListTile(
                                value: answersTiles[i - 1].isChecked,
                                onChanged: (value) {
                                  answersTiles[i - 1].isChecked = value!;
                                  setState(() {});
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(
                                  state.activeQuiz!.questions[index]
                                      .answers[i - 1].text,
                                ),
                              ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Divider(
                color: Constants.mainColor,
              ),
              ElevatedButton(
                onPressed: () {
                  var haveAnswer = false;
                  if (groupValue != 0) {
                    haveAnswer = true;
                  }
                  if (answersTiles.isNotEmpty) {
                    for (var i = 0; i < answersTiles.length; i++) {
                      if (answersTiles[i].isChecked == true) {
                        haveAnswer = true;
                      }
                    }
                  }
                  if (haveAnswer) {
                    if (answersTiles.isNotEmpty) {
                      for (var i = 0; i < answersTiles.length; i++) {
                        if (answersTiles[i].isChecked == true) {
                          answers.add(
                              state.activeQuiz!.questions[index].answers[i]);
                        }
                      }
                    } else {
                      answers.add(
                        state.activeQuiz!.questions[index]
                            .answers[groupValue - 1],
                      );
                    }

                    groupValue = 0;
                    answersTiles = [];
                    showMsg = false;

                    if (_controller!.page?.toInt() ==
                        state.activeQuiz!.questions.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            answersList: answers,
                          ),
                        ),
                      );
                    } else {
                      _controller!.nextPage(
                        duration: Duration(
                          milliseconds: 250,
                        ),
                        curve: Curves.easeInExpo,
                      );
                      setState(() {
                        btnPressed = false;
                      });
                    }
                  } else {
                    setState(() {
                      showMsg = true;
                    });
                  }
                },
                style: Constants.customElevatedButtonStyle,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: Text(
                    btnText,
                    style: TextStyle(color: Constants.mainColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnswerTileModel {
  int id;
  bool isChecked;

  AnswerTileModel({
    required this.id,
    required this.isChecked,
  });
}

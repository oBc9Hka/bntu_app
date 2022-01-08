import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, required this.isFacultiesQuiz}) : super(key: key);
  final bool isFacultiesQuiz;

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
  String checkedLetter = '';

  List<QuestionModel> _questions = [];

  Map<String, bool> checkedAnswers = {};
  var tmpArray = [];
  var tagsArray = [];

  getCheckboxItems(int index) {
    tmpArray = [];
    checkedAnswers.forEach((key, value) {
      print('key: $key');
      if (value == true) {
        tmpArray.add(key);
      }
    });

    handleCheck(index);
  }

  handleCheck(int index) {
    tmpArray.forEach((tmpKey) {
      QuestionModel temp = _questions[index];
      String tag = '';
      temp.answers!.entries.forEach((e) {
        if (e.key == tmpKey) tag = e.value;
      });
      tagsArray.add(tag);
    });
  }

  Map<String, dynamic> answers = {};
  bool isLoading = true;

  void initAnswers() {
    checkedAnswers = {};
    answers.keys.forEach((e) {
      checkedAnswers[e] = false;
    });
  }

  String errorMsg = '';

  void initQuiz() async {
    try {
      answers = _questions[0].answers!;
      print(answers);
      // setState(() {});
      checkedAnswers = {};
      answers.keys.forEach((e) {
        checkedAnswers[e] = false;
      });
      print(checkedAnswers);
      isLoading = false;
    } catch (e) {
      print('catch');
    }
    // setState(() {});
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  bool isInited = false;

  @override
  Widget build(BuildContext context) {
    const mainColor = Constants.mainColor;
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        if (widget.isFacultiesQuiz) {
          _questions = state.questions;
        } else {
          _questions = Constants.quizQuestionsList;
        }

        if (!isInited) {
          initQuiz();
          isInited = true;
        }
        // answers = _questions[0].answers!;
        // print(answers);
        // // setState(() {});
        // checkedAnswers = {};
        // answers.keys.forEach((e) {
        //   checkedAnswers[e] = false;
        // });
        // print(checkedAnswers);
        return Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            title: Text('Тест на ${widget.isFacultiesQuiz ? 'факультет' : 'специальность'}'),
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
                        initAnswers();
                        if (_questions.isNotEmpty) {
                          if (page == _questions.length - 1) {
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
                      itemCount: _questions.length,
                      itemBuilder: (context, index) {
                        answers = _questions[index].answers!;
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Вопрос ${index + 1}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 28.0,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: mainColor,
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
                                  Column(
                                    children: [
                                      Text(
                                        _questions[index].question!,
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                        ),
                                        child: ListView(
                                          children: [
                                            for (int i = 1;
                                                i <= checkedAnswers.keys.length;
                                                i++)
                                              RadioListTile(
                                                title: Text(checkedAnswers.keys
                                                    .elementAt(i - 1)),
                                                value: i,
                                                groupValue: groupValue,
                                                onChanged: (T) {
                                                  print(T);
                                                  setState(() {
                                                    groupValue = T as int;
                                                    checkedAnswers.values
                                                        .map((e) => e = false);
                                                    checkedAnswers[
                                                        checkedAnswers.keys
                                                            .elementAt(
                                                                i - 1)] = true;
                                                    // checkedLetter = checkedAnswers.values.elementAt(i - 1);
                                                  });
                                                },
                                              ),
                                          ],
                                        ),
                                      ),

                                      // ...checkedAnswers.keys.map((key) {
                                      //   return CheckboxListTile(
                                      //     title: Text(key),
                                      //     value: checkedAnswers[key],
                                      //     activeColor: mainColor,
                                      //     onChanged: (bool? value) {
                                      //       setState(() {
                                      //         checkedAnswers[key] = value!;
                                      //       });
                                      //     },
                                      //   );
                                      // }),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: mainColor,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  getCheckboxItems(_controller!.page!.toInt());
                                  // if (!checkedAnswers.values.contains(true)) {
                                  if (groupValue == 0) {
                                    setState(() {
                                      showMsg = true;
                                    });
                                  } else {
                                    groupValue = 0;
                                    showMsg = false;
                                    // tagsArray.add(value);
                                    if (_controller!.page?.toInt() ==
                                        _questions.length - 1) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultScreen(
                                            tagsList: tagsArray,
                                            isFacultiesQuiz:
                                                widget.isFacultiesQuiz,
                                          ),
                                        ),
                                      );
                                    } else {
                                      _controller!.nextPage(
                                          duration: Duration(milliseconds: 250),
                                          curve: Curves.easeInExpo);
                                      setState(() {
                                        btnPressed = false;
                                      });
                                    }
                                  }
                                },
                                style: Constants.customElevatedButtonStyle,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 24.0),
                                  child: Text(
                                    btnText,
                                    style: TextStyle(color: mainColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}

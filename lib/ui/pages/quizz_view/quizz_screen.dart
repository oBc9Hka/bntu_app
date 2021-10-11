import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/util/data.dart';
import 'package:flutter/material.dart';

import 'result_screen.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Следующий вопрос";
  bool answered = false;
  bool showMsg = false;

  List _questions = [];

  Map<String, bool> checkedAnswers = {};
  var tmpArray = [];
  var tagsArray = [];

  getCheckboxItems(int index) {
    tmpArray = [];
    checkedAnswers.forEach((key, value) {
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

  bool isError = false;
  String errorMsg = '';

  void initQuiz() async {
    _questions = await Data()
        .initQuestions()
        .whenComplete(() => isLoading = false)
        .onError((error, stackTrace) {
      errorMsg = error.toString();
      isError = true;
      setState(() {});
      return [];
    });
    if (!isError) {
      answers = _questions[0].answers;
      setState(() {});
      checkedAnswers = {};
      answers.keys.forEach((e) {
        checkedAnswers[e] = false;
      });

      setState(() {});
    }
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    initQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color.fromARGB(255, 0, 138, 94); // green color
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Тест'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Data().mainColor,
              ),
            )
          : isError
              ? Center(
                  child: Text(
                    errorMsg,
                    textAlign: TextAlign.center,
                  ),
                )
              : PageView.builder(
                  controller: _controller!,
                  onPageChanged: (page) {
                    initAnswers();
                    if (_questions.length != 0) {
                      if (page == _questions.length - 1) {
                        setState(() {
                          btnText = "Увидеть результат";
                        });
                      }
                    }
                    setState(() {
                      answered = false;
                    });
                  },
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    answers = _questions[index].answers;
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Вопрос ${index + 1}",
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
                                  'Необходимо выбрать минимум один вариант ответа',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                _questions[index].question,
                                style: TextStyle(fontSize: 24),
                              ),
                              ...checkedAnswers.keys.map((key) {
                                return CheckboxListTile(
                                  title: Text(key),
                                  value: checkedAnswers[key],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      checkedAnswers[key] = value!;
                                    });
                                  },
                                );
                              }),
                            ],
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              getCheckboxItems(_controller!.page!.toInt());
                              if (!checkedAnswers.values.contains(true)) {
                                setState(() {
                                  showMsg = true;
                                });
                              } else {
                                showMsg = false;
                                if (_controller!.page?.toInt() ==
                                    _questions.length - 1) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResultScreen(
                                                tagsList: tagsArray,
                                              )));
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
                            shape: StadiumBorder(),
                            fillColor: Colors.white,
                            padding: EdgeInsets.all(18.0),
                            elevation: 10.0,
                            child: Text(
                              btnText,
                              style: TextStyle(color: mainColor),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
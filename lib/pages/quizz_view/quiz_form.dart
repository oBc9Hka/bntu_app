import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({Key? key, this.question, required this.isEdit})
      : super(key: key);
  final QuestionModel? question;
  final bool isEdit;

  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _questionController = TextEditingController();

  TextEditingController _answer1Controller = TextEditingController();
  TextEditingController _answer2Controller = TextEditingController();
  TextEditingController _answer3Controller = TextEditingController();
  TextEditingController _answer4Controller = TextEditingController();
  TextEditingController _answer5Controller = TextEditingController();
  bool _answer3Visible = false;
  bool _answer4Visible = false;
  bool _answer5Visible = false;

  void checkForVisibility() {
    if (_answer2Controller.text != '') {
      _answer3Visible = true;
    } else {
      _answer3Visible = false;
    }
    if (_answer3Controller.text != '') {
      _answer4Visible = true;
    } else {
      _answer4Visible = false;
    }
    if (_answer4Controller.text != '') {
      _answer5Visible = true;
    } else {
      _answer5Visible = false;
    }
    setState(() {});
  }

  List<String> _facultiesList = ['...'];

  String dropdown1Value = '...';
  String dropdown2Value = '...';
  String dropdown3Value = '...';
  String dropdown4Value = '...';
  String dropdown5Value = '...';

  Map<String, dynamic> _answers = {};

  _setAnswers() {
    _answers = {};
    if (_answer1Controller.text.trim() != '')
      _answers[_answer1Controller.text.trim()] = dropdown1Value;
    if (_answer2Controller.text.trim() != '')
      _answers[_answer2Controller.text.trim()] = dropdown2Value;
    if (_answer3Controller.text.trim() != '')
      _answers[_answer3Controller.text.trim()] = dropdown3Value;
    if (_answer4Controller.text.trim() != '')
      _answers[_answer4Controller.text.trim()] = dropdown4Value;
    if (_answer5Controller.text.trim() != '')
      _answers[_answer5Controller.text.trim()] = dropdown5Value;
  }

  _addQuestion() {
    if (_formKey.currentState!.validate()) {
      _setAnswers();
      QuestionModel().addQuestion(_questionController.text.trim(), _answers);
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Вопрос успешно добавлен');
    }
  }

  _editQuestion(String id) {
    if (_formKey.currentState!.validate()) {
      _setAnswers();
      QuestionModel().editQuestion(id, _questionController.text.trim(), _answers);
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Вопрос успешно изменён');
    }
  }

  void _removeQuestion(
      BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 22,
            child: const Center(
              child: Text(
                'Хотите удалить вопрос?',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                QuestionModel().removeQuestion(id);
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: 'Вопрос успешно удалён');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38),
              ),
              child: const Text(
                'Отмена',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }

  getData() async {
    _facultiesList = await Data().getFacultiesShortNames();
    dropdown1Value = _facultiesList[0];
    dropdown2Value = _facultiesList[0];
    dropdown3Value = _facultiesList[0];
    dropdown4Value = _facultiesList[0];
    dropdown5Value = _facultiesList[0];
    setState(() {});
  }

  getData4Edit() async {
    String initValue = 'ФТК';
    _facultiesList = await Data().getFacultiesShortNames();

    initValue = _facultiesList[0];
    dropdown1Value = initValue;
    dropdown2Value = initValue;
    dropdown3Value = initValue;
    dropdown4Value = initValue;
    dropdown5Value = initValue;

    List<String> values = [
      initValue,
      initValue,
      initValue,
      initValue,
      initValue,
    ];

    int i = 0;
    widget.question!.answers!.values.forEach((element) {
      values[i] = element;
      ++i;
    });

    dropdown1Value = values[0];
    dropdown2Value = values[1];
    dropdown3Value = values[2];
    dropdown4Value = values[3];
    dropdown5Value = values[4];

    setState(() {});
  }

  @override
  void initState() {
    if (widget.isEdit) {
      getData4Edit();
    } else {
      getData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _answerControllersList = [
      _answer1Controller,
      _answer2Controller,
      _answer3Controller,
      _answer4Controller,
      _answer5Controller,
    ];
    if (widget.isEdit) {
      int i = 0;
      _questionController.text = widget.question!.question!;
      widget.question!.answers!.keys.forEach((element) {
        _answerControllersList[i].text = element;
        ++i;
      });
    }

    checkForVisibility();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _questionController,
                    validator: (value) {
                      if (value == '') {
                        return 'Введите вопрос';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Вопрос'),
                    minLines: 1,
                    maxLines: 2,
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _answer1Controller,
                          validator: (value) {
                            if (value == '') {
                              return 'Введите ответ';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Ответ 1'),
                          minLines: 1,
                          maxLines: 2,
                          onChanged: (value) {
                            checkForVisibility();
                          },
                        ),
                      ),
                      DropdownButton(
                        value: dropdown1Value,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdown1Value = newValue!;
                          });
                        },
                        items: _facultiesList
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                  Visibility(
                    visible: true,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _answer2Controller,
                            validator: (value) {
                              if (value == '') {
                                return 'Введите ответ';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Ответ 2'),
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (value) {
                              checkForVisibility();
                            },
                          ),
                        ),
                        DropdownButton(
                          value: dropdown2Value,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdown2Value = newValue!;
                            });
                          },
                          items: _facultiesList
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _answer3Visible,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _answer3Controller,
                            decoration:
                                const InputDecoration(labelText: 'Ответ 3'),
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (value) {
                              checkForVisibility();
                            },
                          ),
                        ),
                        DropdownButton(
                          value: dropdown3Value,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdown3Value = newValue!;
                            });
                          },
                          items: _facultiesList
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _answer4Visible,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _answer4Controller,
                            decoration:
                                const InputDecoration(labelText: 'Ответ 4'),
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (value) {
                              checkForVisibility();
                            },
                          ),
                        ),
                        DropdownButton(
                          value: dropdown4Value,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdown4Value = newValue!;
                            });
                          },
                          items: _facultiesList
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _answer5Visible,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _answer5Controller,
                            decoration:
                                const InputDecoration(labelText: 'Ответ 5'),
                            minLines: 1,
                            maxLines: 2,
                            onChanged: (value) {
                              checkForVisibility();
                            },
                          ),
                        ),
                        DropdownButton(
                          value: dropdown5Value,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdown5Value = newValue!;
                            });
                          },
                          items: _facultiesList
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.isEdit
                      ? ElevatedButton(
                          onPressed: () {
                            _editQuestion(widget.question!.id!);
                          },
                          child: Text('Изменить'),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Data().mainColor),
                            minimumSize:
                                MaterialStateProperty.all(Size(150, 50)),
                            elevation: MaterialStateProperty.all(10),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Data().mainColor),
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _addQuestion();
                          },
                          child: Text('Добавить'),
                          style: ButtonStyle(
                            // foregroundColor: MaterialStateProperty.all(mainColor),
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 50)),
                            elevation: MaterialStateProperty.all(10),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Data().mainColor),
                              ),
                            ),
                          ),
                        ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Назад'),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Data().mainColor),
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Data().mainColor),
                        ),
                      ),
                    ),
                  ),
                  if (widget.isEdit)
                    ElevatedButton(
                      onPressed: () {
                        // _removeFaculty(context, widget.faculty!);
                        _removeQuestion(context, widget.question!.id!);
                      },
                      child: Icon(Icons.delete),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        elevation: MaterialStateProperty.all(10),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({
    Key? key,
    this.question,
    required this.formKey,
    required this.questionController,
    required this.answer1Controller,
    required this.answer2Controller,
    required this.answer3Controller,
    required this.answer4Controller,
    required this.answer5Controller,
    required this.facultiesList,
    required this.questions,
  }) : super(key: key);

  final QuestionModel? question;
  final GlobalKey<FormState> formKey;

  final TextEditingController questionController;

  final TextEditingController answer1Controller;
  final TextEditingController answer2Controller;
  final TextEditingController answer3Controller;
  final TextEditingController answer4Controller;
  final TextEditingController answer5Controller;
  final List<String> facultiesList;

  final String questions;

  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  bool _answer3Visible = false;
  bool _answer4Visible = false;
  bool _answer5Visible = false;

  final int _maxLines = 5;
  void _checkForVisibility() {
    if (widget.answer2Controller.text != '') {
      _answer3Visible = true;
    } else {
      _answer3Visible = false;
    }

    if (widget.answer3Controller.text != '') {
      _answer4Visible = true;
    } else {
      _answer4Visible = false;
    }

    if (widget.answer4Controller.text != '') {
      _answer5Visible = true;
    } else {
      _answer5Visible = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _checkForVisibility());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        List<String> _dropdownList1 = [];
        List<String> _dropdownList2 = [];

        if (widget.questions == 'f') {
          _dropdownList1 = widget.facultiesList;
          _dropdownList2 = Constants.quizFacAnswersList.map((e) => e.toString()).toList();
        } else if (widget.questions == 's') {
          _dropdownList1 = Constants.quizSpecAnswersList;
          _dropdownList2 = Constants.quizSpecAnswersList;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: widget.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: widget.questionController,
                        validator: (value) {
                          if (value == '') {
                            return 'Введите вопрос';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'Вопрос'),
                        minLines: 1,
                        maxLines: 3,
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: widget.answer1Controller,
                              validator: (value) {
                                if (value == '') {
                                  return 'Введите ответ';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Ответ 1'),
                              minLines: 1,
                              maxLines: _maxLines,
                              onChanged: (value) {
                                _checkForVisibility();
                              },
                            ),
                          ),
                          DropdownButton(
                            value: state.dropdown1Value,
                            onChanged: (String? newValue) {
                              setState(() {
                                state.dropdown1Value = newValue!;
                              });
                            },
                            items: _dropdownList1.map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            ).toList(),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          DropdownButton(
                            value: state.dropdown12Value,
                            onChanged: (String? newValue) {
                              setState(() {
                                state.dropdown12Value = newValue!;
                              });
                            },
                            items: _dropdownList2.map(
                                  (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            ).toList(),
                          )
                        ],
                      ),
                      Visibility(
                        visible: true,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: widget.answer2Controller,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Введите ответ';
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Ответ 2'),
                                minLines: 1,
                                maxLines: _maxLines,
                                onChanged: (value) {
                                  _checkForVisibility();
                                },
                              ),
                            ),
                            DropdownButton(
                              value: state.dropdown2Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown2Value = newValue!;
                                });
                              },
                              items: _dropdownList1.map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            DropdownButton(
                              value: state.dropdown22Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown22Value = newValue!;
                                });
                              },
                              items: _dropdownList2.map(
                                    (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
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
                                controller: widget.answer3Controller,
                                decoration:
                                    const InputDecoration(labelText: 'Ответ 3'),
                                minLines: 1,
                                maxLines: _maxLines,
                                onChanged: (value) {
                                  _checkForVisibility();
                                },
                              ),
                            ),
                            DropdownButton(
                              value: state.dropdown3Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown3Value = newValue!;
                                });
                              },
                              items: _dropdownList1.map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            DropdownButton(
                              value: state.dropdown32Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown32Value = newValue!;
                                });
                              },
                              items: _dropdownList2.map(
                                    (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
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
                                controller: widget.answer4Controller,
                                decoration:
                                    const InputDecoration(labelText: 'Ответ 4'),
                                minLines: 1,
                                maxLines: _maxLines,
                                onChanged: (value) {
                                  _checkForVisibility();
                                },
                              ),
                            ),
                            DropdownButton(
                              value: state.dropdown4Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown4Value = newValue!;
                                });
                              },
                              items: _dropdownList1.map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            DropdownButton(
                              value: state.dropdown42Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown42Value = newValue!;
                                });
                              },
                              items: _dropdownList2.map(
                                    (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
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
                                controller: widget.answer5Controller,
                                decoration:
                                    const InputDecoration(labelText: 'Ответ 5'),
                                minLines: 1,
                                maxLines: _maxLines,
                                onChanged: (value) {
                                  _checkForVisibility();
                                },
                              ),
                            ),
                            DropdownButton(
                              value: state.dropdown5Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown5Value = newValue!;
                                });
                              },
                              items: _dropdownList1.map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            DropdownButton(
                              value: state.dropdown52Value,
                              onChanged: (String? newValue) {
                                setState(() {
                                  state.dropdown52Value = newValue!;
                                });
                              },
                              items: _dropdownList2.map(
                                    (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ),
                              ).toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

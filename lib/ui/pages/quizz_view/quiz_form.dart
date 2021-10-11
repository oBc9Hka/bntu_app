import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
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

  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  bool _answer3Visible = false;
  bool _answer4Visible = false;
  bool _answer5Visible = false;

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
    print(_answer3Visible);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
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
                        maxLines: 2,
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
                              maxLines: 2,
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
                            items: widget.facultiesList
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
                                maxLines: 2,
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
                              items: widget.facultiesList
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
                                controller: widget.answer3Controller,
                                decoration:
                                    const InputDecoration(labelText: 'Ответ 3'),
                                minLines: 1,
                                maxLines: 2,
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
                              items: widget.facultiesList
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
                                controller: widget.answer4Controller,
                                decoration:
                                    const InputDecoration(labelText: 'Ответ 4'),
                                minLines: 1,
                                maxLines: 2,
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
                              items: widget.facultiesList
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
                                controller: widget.answer5Controller,
                                decoration:
                                    const InputDecoration(labelText: 'Ответ 5'),
                                minLines: 1,
                                maxLines: 2,
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
                              items: widget.facultiesList
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
              ],
            ),
          ),
        );
      },
    );
  }
}

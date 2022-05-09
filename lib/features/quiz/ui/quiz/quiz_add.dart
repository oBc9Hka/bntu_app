import 'package:bntu_app/core/widgets/add_buttons_section.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/custom_text_field.dart';

class QuizAdd extends StatefulWidget {
  const QuizAdd({Key? key}) : super(key: key);

  @override
  State<QuizAdd> createState() => _QuizAddState();
}

class _QuizAddState extends State<QuizAdd> {
  final _formKey = GlobalKey<FormState>();
  final coeffController = TextEditingController();
  String? quizType;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Добавление теста'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          validator: (value) {
                            if (value == '') {
                              return 'Введите название';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            state.quizInEdit =
                                state.quizInEdit!.copyWith(quizName: value);
                          },
                          labelText: 'Название теста',
                        ),
                        CustomTextFormField(
                          validator: (value) {
                            if (value == '') {
                              return 'Введите описание';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            state.quizInEdit = state.quizInEdit!
                                .copyWith(quizDescription: value);
                          },
                          labelText: 'Описание теста',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AddButtonsSection(
                onAddPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await state.addQuiz();
                    Navigator.pop(context);
                    await Fluttertoast.showToast(msg: 'Тест успешно создан');
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

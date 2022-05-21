import 'package:bntu_app/features/quiz/ui/questions/question_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/add_buttons_section.dart';
import '../../provider/quiz_provider.dart';

class QuestionAdd extends StatelessWidget {
  const QuestionAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    void _addQuestion(QuizProvider state) async {
      if (_formKey.currentState!.validate()) {
        await state.addQuestion();
        Navigator.of(context).pop();
        await Fluttertoast.showToast(msg: 'Вопрос успешно добавлен');
      }
    }

    return Consumer<QuizProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Добавление вопроса'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: QuestionForm(
                    formKey: _formKey,
                  ),
                ),
              ),
              AddButtonsSection(
                onAddPressed: () {
                  _addQuestion(state);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

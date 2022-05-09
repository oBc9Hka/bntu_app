import 'package:bntu_app/features/quiz/ui/questions/question_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/edit_buttons_section.dart';
import '../../../../core/widgets/remove_item.dart';
import '../../provider/quiz_provider.dart';

class QuestionEdit extends StatelessWidget {
  const QuestionEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Consumer<QuizProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Редактирование вопроса'),
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
              EditButtonsSection(
                onEditPressed: () {
                  if (_formKey.currentState!.validate()) {
                    state.editQuestion();

                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: 'Вопрос успешно изменён');
                  }
                },
                onRemovePressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RemoveItem(
                        itemName: 'вопрос',
                        onRemovePressed: () {
                          state.removeQuestion();

                          Navigator.pop(context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: 'Вопрос успешно удалён');
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

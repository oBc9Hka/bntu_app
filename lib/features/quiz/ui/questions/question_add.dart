import 'package:bntu_app/core/enums/question__types.dart';
import 'package:bntu_app/features/quiz/ui/questions/question_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/add_buttons_section.dart';
import '../../domain/models/question_model.dart';
import '../../provider/quiz_provider.dart';

class QuestionAdd extends StatefulWidget {
  const QuestionAdd({Key? key}) : super(key: key);

  @override
  _QuestionAddState createState() => _QuestionAddState();
}

class _QuestionAddState extends State<QuestionAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late QuestionModel questionModel;

  void _addQuestion(QuizProvider state) async {
    if (_formKey.currentState!.validate()) {
      state.quizInEdit!.questions.add(questionModel);
      await state.editQuestions();
      Navigator.of(context).pop();
      await Fluttertoast.showToast(msg: 'Вопрос успешно добавлен');
    }
  }

  @override
  void initState() {
    questionModel = QuestionModel(
      question: '',
      questionType: QuiestionTypes.single_answer,
      answers: [],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    questionModel: questionModel,
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

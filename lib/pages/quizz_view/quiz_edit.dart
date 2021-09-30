import 'package:bntu_app/pages/quizz_view/quiz_form.dart';
import 'package:bntu_app/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key, required this.question}) : super(key: key);

  final QuestionModel question;
  @override
  _QuizEditState createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование вопроса'),
      ),
      body: QuizForm(isEdit: true, question: widget.question),
    );
  }
}

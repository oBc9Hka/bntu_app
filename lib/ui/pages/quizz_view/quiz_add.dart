import 'package:bntu_app/ui/pages/quizz_view/quiz_form.dart';
import 'package:flutter/material.dart';

class QuizAdd extends StatefulWidget {
  const QuizAdd({Key? key}) : super(key: key);

  @override
  _QuizAddState createState() => _QuizAddState();
}

class _QuizAddState extends State<QuizAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление вопроса'),
      ),
      body: QuizForm(isEdit: false,),
    );
  }
}

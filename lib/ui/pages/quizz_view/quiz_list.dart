import 'dart:async';

import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/ui/pages/quizz_view/quiz_add.dart';
import 'package:bntu_app/ui/pages/quizz_view/quiz_edit.dart';
import 'package:bntu_app/util/data.dart';
import 'package:flutter/material.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<QuestionModel> _questions = [];

  void initQuiz() async {
    _questions = await Data().initQuestions();
    setState(() {});
  }

  @override
  void initState() {
    initQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список вопросов'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => QuizAdd()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initQuiz();
        },
        child: Icon(
          Icons.repeat,
          color: Colors.white,
        ),
        backgroundColor: Data().mainColor,
      ),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(_questions[index].question.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return QuizEdit(
                        question: _questions[index],
                      );
                    }));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Data().mainColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (index > 0)
                      QuestionModel().moveUp(
                          _questions[index].id!, _questions[index - 1].id!);

                    Timer(Duration(seconds: 1), () {
                      initQuiz();
                    });
                  },
                  tooltip: 'Поднять в списке',
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Data().mainColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    try {
                      QuestionModel().moveDown(
                          _questions[index].id!, _questions[index + 1].id!);

                      Timer(Duration(seconds: 1), () {
                        initQuiz();
                      });
                    } catch (e) {}
                  },
                  tooltip: 'Опустить в списке',
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Data().mainColor,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._questions[index]
                    .answers!
                    .entries
                    .map((e) => Text('${e.key}: "${e.value}"')),
              ],
            ),
          );
        },
      ),
    );
  }
}

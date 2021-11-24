import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/pages/quizz_view/quiz_add.dart';
import 'package:bntu_app/ui/pages/quizz_view/quiz_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<QuestionModel> _questions = [];

  @override
  Widget build(BuildContext context) {
    const mainColor = Constants.mainColor;
    return Consumer<AppProvider>(builder: (context, state, child) {
      _questions = state.questions;
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
            IconButton(
                onPressed: () {
                  state.initQuestions();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: ListView.builder(
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return QuizEdit(
                              question: _questions[index],
                            );
                          }));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: mainColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          try {
                            state.moveUpQuestion(
                              _questions[index].id!,
                              _questions[index - 1].id!,
                            );
                          } catch (e) {}
                        },
                        tooltip: 'Поднять в списке',
                        icon: Icon(
                          Icons.arrow_upward,
                          color: mainColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          try {
                            state.moveDownQuestion(
                              _questions[index].id!,
                              _questions[index + 1].id!,
                            );
                          } catch (e) {}
                        },
                        tooltip: 'Опустить в списке',
                        icon: Icon(
                          Icons.arrow_downward,
                          color: mainColor,
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
          ),
        ),
      );
    });
  }
}

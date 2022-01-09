import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/pages/quiz_view/quiz_add.dart';
import 'package:bntu_app/ui/pages/quiz_view/quiz_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key, required this.questions}) : super(key: key);
  final String questions;

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  List<QuestionModel> _questions = [];

  @override
  Widget build(BuildContext context) {
    const mainColor = Constants.mainColor;
    return Consumer<AppProvider>(builder: (context, state, child) {
      if (widget.questions == 'f') {
        _questions = state.facultiesQuestions;
      } else if (widget.questions == 's') {
        _questions = state.specialtiesQuestions;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text('Список вопросов'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => QuizAdd(
                      questions: widget.questions,
                    ),
                  ),
                );
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                    child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(
                        _questions[index].question.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._questions[index].answers!.map((e) => Text(
                              '${e.entries.first.key.length <= 10 ? e.entries.first.key.toString().trimRight() : e.entries.first.key.substring(0, 10).toString().trimRight() + '..'}: ${e.values.first}')),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return QuizEdit(
                                  question: _questions[index],
                                  questions: widget.questions,
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
                                if (widget.questions == 'f') {
                                  state.moveUpFacultyQuestion(
                                    _questions[index].id!,
                                    _questions[index - 1].id!,
                                  );
                                } else if (widget.questions == 's') {
                                  state.moveUpSpecialityQuestion(
                                    _questions[index].id!,
                                    _questions[index - 1].id!,
                                  );
                                }
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
                                if (widget.questions == 'f') {
                                  state.moveDownFacultyQuestion(
                                    _questions[index].id!,
                                    _questions[index + 1].id!,
                                  );
                                } else if (widget.questions == 's') {
                                  state.moveDownSpecialityQuestion(
                                    _questions[index].id!,
                                    _questions[index + 1].id!,
                                  );
                                }
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
                    ),
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

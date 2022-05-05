import 'package:auto_size_text/auto_size_text.dart';
import 'package:bntu_app/core/widgets/list_veiw_reordable.dart';
import 'package:bntu_app/core/widgets/save_changes.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../core/constants/constants.dart';
import '../questions/question_add.dart';
import '../questions/question_edit.dart';

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key}) : super(key: key);

  @override
  _QuizEditState createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {
  TextEditingController quizController = TextEditingController();

  Future<bool> _onWillPop(QuizProvider state) async {
    if (state.quizInEditInitState == state.quizInEdit) {
      print('oops');
      state.clearQuizModel();
      await state.getQuizList();
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SaveChanges(
            onSavePressed: () async {
              await state.editQuiz(quiz: state.quizInEdit!);
              await Fluttertoast.showToast(msg: 'Изменения сохранены');
              await state.getQuizList();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            onNoPressed: () async {
              await state.getQuizList();
            },
          );
        },
      );
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Constants.mainColor;
    return Consumer<QuizProvider>(builder: (context, state, child) {
      return WillPopScope(
        onWillPop: () {
          return _onWillPop(state);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Список вопросов'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => QuestionAdd(
                          // quizModel: widget.quiz,
                          ),
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
              // IconButton(
              //   onPressed: () {
              //     state.getQuizList();
              //   },
              //   icon: Icon(Icons.refresh),
              // )
            ],
          ),
          body: state.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: Column(
                    children: [
                      Form(
                        child: TextFormField(
                          controller: TextEditingController(
                              text: state.quizInEdit!.quizName),
                          onChanged: (value) {
                            state.quizInEdit!.quizName = value;
                          },
                        ),
                      ),
                      state.quizInEdit!.questions.isNotEmpty
                          ? ListViewReordable(
                              onReorder: (oldIndex, newIndex) {
                                state.reorderQuestions(oldIndex, newIndex);
                              },
                              children: [
                                for (var index = 0;
                                    index < state.quizInEdit!.questions.length;
                                    index++)
                                  Card(
                                    child: ListTile(
                                      leading: Text('${index + 1}'),
                                      title: Text(
                                        state.quizInEdit!.questions[index]
                                            .question,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...state.quizInEdit!.questions[index]
                                              .answers
                                              .map(
                                            (e) => AutoSizeText(
                                              '${e.text.length <= 10 ? e.text.trimRight() : e.text.substring(0, 10).toString().trimRight() + '..'}: ${e.coefficients}',
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              state.setQuestionInEdit(index);

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return QuestionEdit();
                                              }));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : Expanded(
                              child: Center(
                                child: Text('Список вопросов пуст'),
                              ),
                            ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}

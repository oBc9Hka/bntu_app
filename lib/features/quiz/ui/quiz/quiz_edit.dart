import 'package:auto_size_text/auto_size_text.dart';
import 'package:bntu_app/core/widgets/list_veiw_reordable.dart';
import 'package:bntu_app/core/widgets/remove_item.dart';
import 'package:bntu_app/core/widgets/save_changes.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:bntu_app/features/quiz/ui/quiz/coefficients_screen.dart';
import 'package:bntu_app/features/settings/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/enums/question__types.dart';
import '../../domain/models/question_model.dart';
import '../questions/question_add.dart';
import '../questions/question_edit.dart';

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key}) : super(key: key);

  @override
  _QuizEditState createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {
  TextEditingController quizController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<bool> _onWillPop(
      QuizProvider state, SettingsProvider settingsProvider) async {
    if (_formKey.currentState!.validate()) {
      if (!state.haveChanges()) {
        await state.getAllQuizList();
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SaveChanges(
              onSavePressed: () async {
                await state.editQuiz(
                  quiz: state.quizInEdit!,
                );
                await Fluttertoast.showToast(msg: 'Изменения сохранены');
                await state.getAllQuizList();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              onNoPressed: () async {
                await state.getAllQuizList();
              },
            );
          },
        );
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = context.watch<SettingsProvider>();
    const mainColor = Constants.mainColor;
    return Consumer<QuizProvider>(builder: (context, state, child) {
      return WillPopScope(
        onWillPop: () {
          return _onWillPop(state, settingsState);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Список вопросов'),
            actions: [
              IconButton(
                onPressed: () {
                  state.questionInEdit = QuestionModel(
                    question: '',
                    questionType: QuestionTypes.single_answer,
                    answers: [],
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => QuestionAdd(),
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return RemoveItem(
                        itemName: 'тест',
                        onRemovePressed: () {
                          settingsState.quizIds.remove(state.quizInEdit!.docId);
                          state.deleteQuiz();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete),
              )
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
                        key: _formKey,
                        child: TextFormField(
                          controller: TextEditingController(
                              text: state.quizInEdit!.quizName),
                          onChanged: (value) {
                            state.quizInEdit =
                                state.quizInEdit!.copyWith(quizName: value);
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'Заполните поле';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CoefficientsScreen();
                            },
                          );
                        },
                        child: Text(
                          'Редактирование коэффициентов',
                        ),
                      ),
                      state.quizInEdit!.questions.isNotEmpty
                          ? Flexible(
                              child: Scaffold(
                                body: ListViewReordable(
                                  onReorder: (oldIndex, newIndex) {
                                    state.reorderQuestions(oldIndex, newIndex);
                                  },
                                  children: [
                                    for (var index = 0;
                                        index <
                                            state.quizInEdit!.questions.length;
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
                                              ...state.quizInEdit!
                                                  .questions[index].answers
                                                  .map(
                                                (e) => AutoSizeText(
                                                  '${e.text.length <= 10 ? e.text.trimRight() : e.text.substring(0, 10).toString().trimRight() + '..'}: ${e.coefficients}',
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  state
                                                      .setQuestionInEdit(index);

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
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
                                ),
                              ),
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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/models/question_model.dart';

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key, required this.quiz}) : super(key: key);
  final QuizModel quiz;

  @override
  _QuizEditState createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {
  late QuizModel quizEditModel;
  List<QuestionModel> _questions = [];
  TextEditingController quizController = TextEditingController();

  @override
  void initState() {
    quizEditModel = QuizModel(
      docId: widget.quiz.docId,
      quizName: widget.quiz.quizName,
      quizType: widget.quiz.quizType,
      questions: widget.quiz.questions,
      isVisible: widget.quiz.isVisible,
    );
    quizController = TextEditingController(text: quizEditModel.quizName);
    super.initState();
  }

  Future<bool> _onWillPop(QuizProvider state) async {
    if (quizEditModel == widget.quiz) {
    } else {
      await state.editQuiz(quiz: quizEditModel);
      await Fluttertoast.showToast(msg: 'Изменения сохранены');
      await state.getQuizList();
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
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => QuestionAdd(
                  //       questions: widget.questions,
                  //     ),
                  //   ),
                  // );
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  state.getQuizList();
                },
                icon: Icon(Icons.refresh),
              )
            ],
          ),
          body: Container(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: Column(
              children: [
                Form(
                  child: TextFormField(
                    controller: quizController,
                    onChanged: (value) {
                      quizEditModel.quizName = value;
                      setState(() {});
                    },
                  ),
                ),
                quizEditModel.questions != null &&
                        quizEditModel.questions!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: quizEditModel.questions!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = quizEditModel.questions![index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Card(
                              child: ListTile(
                                leading: Text('${index + 1}'),
                                title: Text(
                                  item.question,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...item.answers.map(
                                      (e) => AutoSizeText(
                                        '${e.text.length <= 10 ? e.text.trimRight() : e.text.substring(0, 10).toString().trimRight() + '..'}: ${e.coefficients.first}',
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
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (BuildContext context) {
                                        //   return QuestionEdit(
                                        //     question: _questions[index],
                                        //     questions: widget.questions,
                                        //   );
                                        // }));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: mainColor,
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     // try {
                                    //     //   if (widget.questions == 'f') {
                                    //     //     state.moveUpFacultyQuestion(
                                    //     //       _questions[index].id!,
                                    //     //       _questions[index - 1].id!,
                                    //     //     );
                                    //     //   } else if (widget.questions == 's') {
                                    //     //     state.moveUpSpecialityQuestion(
                                    //     //       _questions[index].id!,
                                    //     //       _questions[index - 1].id!,
                                    //     //     );
                                    //     //   }
                                    //     //   // ignore: empty_catches
                                    //     // } catch (e) {}
                                    //   },
                                    //   tooltip: 'Поднять в списке',
                                    //   icon: Icon(
                                    //     Icons.arrow_upward,
                                    //     color: mainColor,
                                    //   ),
                                    // ),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     // try {
                                    //     //   if (widget.questions == 'f') {
                                    //     //     state.moveDownFacultyQuestion(
                                    //     //       _questions[index].id!,
                                    //     //       _questions[index + 1].id!,
                                    //     //     );
                                    //     //   } else if (widget.questions == 's') {
                                    //     //     state.moveDownSpecialityQuestion(
                                    //     //       _questions[index].id!,
                                    //     //       _questions[index + 1].id!,
                                    //     //     );
                                    //     //   }
                                    //     //   // ignore: empty_catches
                                    //     // } catch (e) {}
                                    //   },
                                    //   tooltip: 'Опустить в списке',
                                    //   icon: Icon(
                                    //     Icons.arrow_downward,
                                    //     color: mainColor,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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

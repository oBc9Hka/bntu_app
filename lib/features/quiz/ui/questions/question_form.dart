import 'package:bntu_app/core/constants/constants.dart';
import 'package:bntu_app/core/widgets/custom_text_field.dart';
import 'package:bntu_app/features/quiz/domain/models/answer_model.dart';
import 'package:bntu_app/features/quiz/domain/models/coeff_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/quiz_provider.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  void addAnswer(QuizProvider state) {
    var list = state.questionInEdit!.answers.map((e) => e.copyWith()).toList();
    list.add(
      Answer(
        text: '',
        coefficients: [],
      ),
    );
    state.questionInEdit = state.questionInEdit!.copyWith(answers: list);

    setState(() {});
  }

  void removeAnswer(index, QuizProvider state) {
    var list = state.questionInEdit!.answers.map((e) => e.copyWith()).toList();
    list.removeAt(index);
    state.questionInEdit = state.questionInEdit!.copyWith(answers: list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, state, child) {
        return SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        labelText: 'Вопрос',
                        controller: TextEditingController(
                            text: state.questionInEdit!.question),
                        validator: (value) {
                          if (value == '') {
                            return 'Заполните поле';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          state.questionInEdit =
                              state.questionInEdit!.copyWith(question: value);
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        state.editAnswersCount();
                      },
                      child: Text(state.questionInEdit!.questionType.name),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.questionInEdit!.answers.length,
                  itemBuilder: (context, index) {
                    return answerTile(index, state);
                  },
                ),
                IconButton(
                  onPressed: () {
                    addAnswer(state);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Constants.mainColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget answerTile(int index, QuizProvider state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CustomTextFormField(
            labelText: 'Ответ ${index + 1}',
            controller: TextEditingController(
                text: state.questionInEdit!.answers[index].text),
            validator: (value) {
              if (value == '') {
                return 'Заполните поле';
              }
              return null;
            },
            onChanged: (value) {
              var list = state.questionInEdit!.answers
                  .map((e) => e.copyWith())
                  .toList();
              list[index] =
                  state.questionInEdit!.answers[index].copyWith(text: value);
              state.questionInEdit =
                  state.questionInEdit!.copyWith(answers: list);
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return customDialog(index, state);
                });
          },
          child: Text('Коэфф.'),
        ),
        IconButton(
          onPressed: () {
            removeAnswer(index, state);
          },
          icon: Icon(
            Icons.clear,
            color: Constants.mainColor,
          ),
        ),
      ],
    );
  }

  Dialog customDialog(int index, QuizProvider state) {
    final items = state.quizInEdit!.coefficients;
    return Dialog(
      child: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              'Выбор коэффициентов',
              style: TextStyle(fontSize: 18),
            ),
            Divider(
              thickness: 2,
            ),
            ListView.builder(
              itemCount:
                  state.questionInEdit!.answers[index].coefficients.length,
              shrinkWrap: true,
              itemBuilder: (context, coeffIndex) {
                return coeffTile(
                  index,
                  coeffIndex,
                  () {
                    var list = state.questionInEdit!.answers
                        .map((e) => e.copyWith())
                        .toList();
                    var cList = list[index]
                        .coefficients
                        .map(
                          (e) => e.copyWith(),
                        )
                        .toList();
                    cList.removeAt(coeffIndex);
                    list[index] = list[index].copyWith(coefficients: cList);

                    state.questionInEdit =
                        state.questionInEdit!.copyWith(answers: list);

                    setState(() {});
                  },
                  setState,
                  state,
                  items,
                );
              },
            ),
            IconButton(
              onPressed: () {
                var list = state.questionInEdit!.answers
                    .map(
                      (e) => e.copyWith(),
                    )
                    .toList();
                var cList = list[index]
                    .coefficients
                    .map(
                      (e) => e.copyWith(),
                    )
                    .toList();

                cList.add(
                  Coeff(
                    key: items.first,
                    weight: 1,
                  ),
                );
                list[index] = list[index].copyWith(coefficients: cList);
                state.questionInEdit =
                    state.questionInEdit!.copyWith(answers: list);
                setState(() {});
              },
              icon: Icon(
                Icons.add,
                color: Constants.mainColor,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget coeffTile(
    int index,
    int coeffIndex,
    Function() onClear,
    setState,
    QuizProvider state,
    List<String> items,
  ) {
    return Row(
      children: [
        IconButton(
          onPressed: onClear,
          icon: Icon(
            Icons.clear,
            color: Constants.mainColor,
          ),
        ),
        Expanded(
          child: DropdownButton<String>(
            value: state
                .questionInEdit!.answers[index].coefficients[coeffIndex].key,
            items: [
              ...items.map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                var list = state.questionInEdit!.answers
                    .map(
                      (e) => e.copyWith(),
                    )
                    .toList();
                var cList = list[index]
                    .coefficients
                    .map(
                      (e) => e.copyWith(),
                    )
                    .toList();
                cList[coeffIndex] = cList[coeffIndex].copyWith(key: value);
                list[index] = list[index].copyWith(coefficients: cList);
                state.questionInEdit =
                    state.questionInEdit!.copyWith(answers: list);

                setState(() {});
              }
            },
          ),
        ),
        // count
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (state.questionInEdit!.answers[index]
                        .coefficients[coeffIndex].weight >
                    1) {
                  var list = state.questionInEdit!.answers
                      .map(
                        (e) => e.copyWith(),
                      )
                      .toList();
                  var cList = list[index]
                      .coefficients
                      .map(
                        (e) => e.copyWith(),
                      )
                      .toList();
                  cList[coeffIndex] = cList[coeffIndex]
                      .copyWith(weight: cList[coeffIndex].weight - 1);
                  list[index] = list[index].copyWith(coefficients: cList);
                  state.questionInEdit =
                      state.questionInEdit!.copyWith(answers: list);

                  setState(() {});
                }
              },
              icon: Icon(
                Icons.remove,
                color: Constants.mainColor,
              ),
            ),
            Text(state
                .questionInEdit!.answers[index].coefficients[coeffIndex].weight
                .toString()),
            IconButton(
              onPressed: () {
                var list = state.questionInEdit!.answers
                    .map(
                      (e) => e.copyWith(),
                    )
                    .toList();
                var cList = list[index]
                    .coefficients
                    .map(
                      (e) => e.copyWith(),
                    )
                    .toList();
                cList[coeffIndex] = cList[coeffIndex]
                    .copyWith(weight: cList[coeffIndex].weight + 1);
                list[index] = list[index].copyWith(coefficients: cList);
                state.questionInEdit =
                    state.questionInEdit!.copyWith(answers: list);

                setState(() {});
              },
              icon: Icon(
                Icons.add,
                color: Constants.mainColor,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget count(int value, setState) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            value--;
          },
          icon: Icon(
            Icons.remove,
            color: Constants.mainColor,
          ),
        ),
        Text(value.toString()),
        IconButton(
          onPressed: () {
            value++;
          },
          icon: Icon(
            Icons.add,
            color: Constants.mainColor,
          ),
        ),
      ],
    );
  }
}

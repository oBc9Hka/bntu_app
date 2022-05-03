import 'package:bntu_app/core/constants/constants.dart';
import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/answer_model.dart';
import 'package:bntu_app/features/quiz/domain/models/coeff_model.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/quiz_provider.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({
    Key? key,
    required this.formKey,
    required this.questionModel,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final QuestionModel questionModel;

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  @override
  void initState() {
    if (widget.questionModel.answers.isEmpty) {
      addAnswer();
    }
    super.initState();
  }

  void addAnswer() {
    widget.questionModel.answers.add(
      Answer(
        text: '',
        coefficients: [],
      ),
    );

    setState(() {});
  }

  void removeAnswer(index) {
    widget.questionModel.answers.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, state, child) {
        var _dropdownList1 = <String>[];
        var _dropdownList2 = <String>[];

        if (state.quizInEdit!.quizType == QuizTypes.single_coeff) {
          _dropdownList1 = ['ФТК', 'ФИТР', 'МСФ', 'АТФ'];
          _dropdownList2 =
              Constants.quizFacAnswersList.map((e) => e.toString()).toList();
        } else if (state.quizInEdit!.quizType == QuizTypes.multiple_coeff) {
          _dropdownList1 = Constants.quizSpecAnswersList;
          _dropdownList2 = Constants.quizSpecAnswersList;
        }
        return SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                customTextField(
                  helperText: 'Вопрос',
                  value: widget.questionModel.question,
                  onChanged: (value) {
                    widget.questionModel.question = value;
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.questionModel.answers.length,
                  itemBuilder: (context, index) {
                    return answerTile(index);
                  },
                ),
                IconButton(
                  onPressed: () {
                    addAnswer();
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

  Widget answerTile(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: customTextField(
            helperText: 'Ответ ${index + 1}',
            value: widget.questionModel.answers[index].text,
            onChanged: (value) {
              widget.questionModel.answers[index].text = value;
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
                  return customDialog(index);
                });
          },
          child: Text('Коэфф.'),
        ),
        IconButton(
          onPressed: () {
            removeAnswer(index);
          },
          icon: Icon(
            Icons.clear,
            color: Constants.mainColor,
          ),
        ),
      ],
    );
  }

  final items = ['ФТК', 'ФИТР', 'МСФ', 'АТФ'];
  Dialog customDialog(int index) {
    return Dialog(
      child: StatefulBuilder(builder: (context, setState) {
        return Column(
          children: [
            Text('Выбор коэффициентов'),
            Divider(),
            ListView.builder(
              itemCount:
                  widget.questionModel.answers[index].coefficients.length,
              shrinkWrap: true,
              itemBuilder: (context, coeffIndex) {
                return coeffTile(
                  index,
                  coeffIndex,
                  () {
                    widget.questionModel.answers[index].coefficients
                        .removeAt(coeffIndex);
                    setState(() {});
                  },
                  setState,
                );
              },
            ),
            IconButton(
              onPressed: () {
                widget.questionModel.answers[index].coefficients.add(
                  Coeff(
                    key: items.first,
                    weight: 1,
                  ),
                );
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

  Widget coeffTile(int index, int coeffIndex, Function() onClear, setState) {
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
            value: widget
                .questionModel.answers[index].coefficients[coeffIndex].key,
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
                widget.questionModel.answers[index].coefficients[coeffIndex]
                    .key = value;

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
                if (widget.questionModel.answers[index].coefficients[coeffIndex]
                        .weight >
                    1) {
                  widget.questionModel.answers[index].coefficients[coeffIndex]
                      .weight--;
                  setState(() {});
                }
              },
              icon: Icon(
                Icons.remove,
                color: Constants.mainColor,
              ),
            ),
            Text(widget
                .questionModel.answers[index].coefficients[coeffIndex].weight
                .toString()),
            IconButton(
              onPressed: () {
                widget.questionModel.answers[index].coefficients[coeffIndex]
                    .weight++;
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

  Widget customTextField({
    Function(String)? onChanged,
    String? value,
    String? helperText,
  }) {
    return TextFormField(
      onChanged: onChanged,
      controller: TextEditingController(text: value ?? ''),
      decoration: InputDecoration(helperText: helperText ?? ''),
      validator: (value) {
        if (value == '') {
          return 'Заполните поле';
        }
        return null;
      },
    );
  }
}

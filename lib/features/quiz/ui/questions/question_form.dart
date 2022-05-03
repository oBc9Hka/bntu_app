import 'package:bntu_app/core/enums/question__types.dart';
import 'package:bntu_app/features/quiz/domain/models/answer_model.dart';
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
  // bool _answer3Visible = false;
  // bool _answer4Visible = false;
  // bool _answer5Visible = false;

  // final int _maxLines = 5;
  // void _checkForVisibility() {
  //   if (widget.answer2Controller.text != '') {
  //     _answer3Visible = true;
  //   } else {
  //     _answer3Visible = false;
  //   }

  //   if (widget.answer3Controller.text != '') {
  //     _answer4Visible = true;
  //   } else {
  //     _answer4Visible = false;
  //   }

  //   if (widget.answer4Controller.text != '') {
  //     _answer5Visible = true;
  //   } else {
  //     _answer5Visible = false;
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    // WidgetsBinding.instance?.addPostFrameCallback((_) => _checkForVisibility());
    if (widget.questionModel.answers.isEmpty) {
      widget.questionModel.answers.add(
        Answer(
          text: '',
          coefficients: [],
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, state, child) {
        var _dropdownList1 = <String>[];
        var _dropdownList2 = <String>[];

        // if (widget.questions == 'f') {
        //   _dropdownList1 = widget.facultiesList;
        //   _dropdownList2 =
        //       Constants.quizFacAnswersList.map((e) => e.toString()).toList();
        // } else if (widget.questions == 's') {
        //   _dropdownList1 = Constants.quizSpecAnswersList;
        //   _dropdownList2 = Constants.quizSpecAnswersList;
        // }
        return SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                customTextField(
                  helperText: 'Вопрос',
                  onChanged: (value) {
                    widget.questionModel.question = value;
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.questionModel.answers.length,
                  itemBuilder: (context, index) {
                    return customTextField(
                      helperText: 'Ответ ${index + 1}',
                      onChanged: (value) {
                        widget.questionModel.answers[index].text = value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
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
      },
    );
  }
}

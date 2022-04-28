import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/quiz_view/quiz_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/add_buttons_section.dart';

class QuizAdd extends StatefulWidget {
  const QuizAdd({Key? key, required this.questions}) : super(key: key);
  final String questions;

  @override
  _QuizAddState createState() => _QuizAddState();
}

class _QuizAddState extends State<QuizAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _questionController = TextEditingController();

  final TextEditingController _answer1Controller = TextEditingController();
  final TextEditingController _answer2Controller = TextEditingController();
  final TextEditingController _answer3Controller = TextEditingController();
  final TextEditingController _answer4Controller = TextEditingController();
  final TextEditingController _answer5Controller = TextEditingController();

  List<Map<String, List<String>>> _answers = [];

  void _setAnswers(
    String v1,
    String v2,
    String v3,
    String v4,
    String v5,
    String v12,
    String v22,
    String v32,
    String v42,
    String v52,
  ) {
    _answers = [];
    if (_answer1Controller.text.trim() != '') {
      if (v12 != '..') {
        _answers.add({
          _answer1Controller.text.trim(): [v1, v12]
        });
      } else {
        _answers.add({
          _answer1Controller.text.trim(): [v1]
        });
      }
    }
    if (_answer2Controller.text.trim() != '') {
      if (v22 != '..') {
        _answers.add({
          _answer2Controller.text.trim(): [v2, v22]
        });
      } else {
        _answers.add({
          _answer2Controller.text.trim(): [v2]
        });
      }
    }
    if (_answer3Controller.text.trim() != '') {
      if (v32 != '..') {
        _answers.add({
          _answer3Controller.text.trim(): [v3, v32]
        });
      } else {
        _answers.add({
          _answer3Controller.text.trim(): [v3]
        });
      }
    }
    if (_answer4Controller.text.trim() != '') {
      if (v42 != '..') {
        _answers.add({
          _answer4Controller.text.trim(): [v4, v42]
        });
      } else {
        _answers.add({
          _answer4Controller.text.trim(): [v4]
        });
      }
    }
    if (_answer5Controller.text.trim() != '') {
      if (v52 != '..') {
        _answers.add({
          _answer5Controller.text.trim(): [v5, v52]
        });
      } else {
        _answers.add({
          _answer5Controller.text.trim(): [v5]
        });
      }
    }
  }

  void _addQuestion(AppProvider state) {
    if (_formKey.currentState!.validate()) {
      _setAnswers(
        state.dropdown1Value,
        state.dropdown2Value,
        state.dropdown3Value,
        state.dropdown4Value,
        state.dropdown5Value,
        state.dropdown12Value,
        state.dropdown22Value,
        state.dropdown32Value,
        state.dropdown42Value,
        state.dropdown52Value,
      );
      if (widget.questions == 'f') {
        state.addFacultyQuestion(_questionController.text.trim(), _answers);
      } else if (widget.questions == 's') {
        state.addSpecialityQuestion(_questionController.text.trim(), _answers);
      }
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Вопрос успешно добавлен');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        if (widget.questions == 'f') {
          // state.dropdown1Value = state.facultiesShortNames[0];
          // state.dropdown2Value = state.facultiesShortNames[0];
          // state.dropdown3Value = state.facultiesShortNames[0];
          // state.dropdown4Value = state.facultiesShortNames[0];
          // state.dropdown5Value = state.facultiesShortNames[0];
          state.dropdown12Value = Constants.quizFacAnswersList[0].toString();
          state.dropdown22Value = Constants.quizFacAnswersList[0].toString();
          state.dropdown32Value = Constants.quizFacAnswersList[0].toString();
          state.dropdown42Value = Constants.quizFacAnswersList[0].toString();
          state.dropdown52Value = Constants.quizFacAnswersList[0].toString();
        } else if (widget.questions == 's') {
          state.dropdown1Value = Constants.quizSpecAnswersList[1];
          state.dropdown2Value = Constants.quizSpecAnswersList[1];
          state.dropdown3Value = Constants.quizSpecAnswersList[1];
          state.dropdown4Value = Constants.quizSpecAnswersList[1];
          state.dropdown5Value = Constants.quizSpecAnswersList[1];
          state.dropdown12Value = Constants.quizSpecAnswersList[0];
          state.dropdown22Value = Constants.quizSpecAnswersList[0];
          state.dropdown32Value = Constants.quizSpecAnswersList[0];
          state.dropdown42Value = Constants.quizSpecAnswersList[0];
          state.dropdown52Value = Constants.quizSpecAnswersList[0];
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Добавление вопроса'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: QuizForm(
                    formKey: _formKey,
                    questionController: _questionController,
                    answer1Controller: _answer1Controller,
                    answer2Controller: _answer2Controller,
                    answer3Controller: _answer3Controller,
                    answer4Controller: _answer4Controller,
                    answer5Controller: _answer5Controller,
                    facultiesList: [], //state.facultiesShortNames,
                    questions: widget.questions,
                  ),
                ),
              ),
              AddButtonsSection(
                onAddPressed: () {
                  _addQuestion(state);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/pages/quizz_view/quiz_form.dart';
import 'package:bntu_app/ui/widgets/add_buttons_section.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class QuizAdd extends StatefulWidget {
  const QuizAdd({Key? key, required this.questions}) : super(key: key);
  final String questions;

  @override
  _QuizAddState createState() => _QuizAddState();
}

class _QuizAddState extends State<QuizAdd> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _questionController = TextEditingController();

  TextEditingController _answer1Controller = TextEditingController();
  TextEditingController _answer2Controller = TextEditingController();
  TextEditingController _answer3Controller = TextEditingController();
  TextEditingController _answer4Controller = TextEditingController();
  TextEditingController _answer5Controller = TextEditingController();

  Map<String, dynamic> _answers = {};

  void _setAnswers(
    String v1,
    String v2,
    String v3,
    String v4,
    String v5,
  ) {
    _answers = {};
    if (_answer1Controller.text.trim() != '')
      _answers[_answer1Controller.text.trim()] = v1;
    if (_answer2Controller.text.trim() != '')
      _answers[_answer2Controller.text.trim()] = v2;
    if (_answer3Controller.text.trim() != '')
      _answers[_answer3Controller.text.trim()] = v3;
    if (_answer4Controller.text.trim() != '')
      _answers[_answer4Controller.text.trim()] = v4;
    if (_answer5Controller.text.trim() != '')
      _answers[_answer5Controller.text.trim()] = v5;
  }

  void _addQuestion(AppProvider state) {
    if (_formKey.currentState!.validate()) {
      _setAnswers(
        state.dropdown1Value,
        state.dropdown2Value,
        state.dropdown3Value,
        state.dropdown4Value,
        state.dropdown5Value,
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
          state.dropdown1Value = state.facultiesShortNames[0];
          state.dropdown2Value = state.facultiesShortNames[0];
          state.dropdown3Value = state.facultiesShortNames[0];
          state.dropdown4Value = state.facultiesShortNames[0];
          state.dropdown5Value = state.facultiesShortNames[0];
        } else if (widget.questions == 's') {
          state.dropdown1Value = Constants.quizSpecAnswersList[0];
          state.dropdown2Value = Constants.quizSpecAnswersList[0];
          state.dropdown3Value = Constants.quizSpecAnswersList[0];
          state.dropdown4Value = Constants.quizSpecAnswersList[0];
          state.dropdown5Value = Constants.quizSpecAnswersList[0];
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
                    facultiesList: state.facultiesShortNames,
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

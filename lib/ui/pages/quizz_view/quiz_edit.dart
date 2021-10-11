import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/quizz_view/quiz_form.dart';
import 'package:bntu_app/ui/widgets/edit_buttons_section.dart';
import 'package:bntu_app/ui/widgets/remove_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key, required this.question}) : super(key: key);

  final QuestionModel question;

  @override
  _QuizEditState createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {
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

  _editQuestion(String id, AppProvider state) {
    if (_formKey.currentState!.validate()) {
      _setAnswers(
        state.dropdown1Value,
        state.dropdown2Value,
        state.dropdown3Value,
        state.dropdown4Value,
        state.dropdown5Value,
      );
      state.editQuestion(id, _questionController.text.trim(), _answers);
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Вопрос успешно изменён');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        String initValue = 'ФТК';

        initValue = state.facultiesShortNames[0];
        state.dropdown1Value = initValue;
        state.dropdown2Value = initValue;
        state.dropdown3Value = initValue;
        state.dropdown4Value = initValue;
        state.dropdown5Value = initValue;

        List<String> values = [
          initValue,
          initValue,
          initValue,
          initValue,
          initValue,
        ];

        int i = 0;
        widget.question.answers!.values.forEach((element) {
          values[i] = element;
          ++i;
        });

        state.dropdown1Value = values[0];
        state.dropdown2Value = values[1];
        state.dropdown3Value = values[2];
        state.dropdown4Value = values[3];
        state.dropdown5Value = values[4];

        List<TextEditingController> _answerControllersList = [
          _answer1Controller,
          _answer2Controller,
          _answer3Controller,
          _answer4Controller,
          _answer5Controller,
        ];

        i = 0;
        _questionController.text = widget.question.question!;
        widget.question.answers!.keys.forEach((element) {
          _answerControllersList[i].text = element;
          ++i;
        });

        return Scaffold(
          appBar: AppBar(
            title: Text('Редактирование вопроса'),
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
                  ),
                ),
              ),
              EditButtonsSection(
                onEditPressed: () {
                  _editQuestion(widget.question.id!, state);
                },
                onRemovePressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RemoveItem(
                        itemName: 'вопрос',
                        onRemovePressed: () {
                          state.removeQuestion(widget.question.id!);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: 'Вопрос успешно удалён');
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

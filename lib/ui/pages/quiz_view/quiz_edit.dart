import 'package:bntu_app/models/question_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/pages/quiz_view/quiz_form.dart';
import 'package:bntu_app/ui/widgets/edit_buttons_section.dart';
import 'package:bntu_app/ui/widgets/remove_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key, required this.question, required this.questions})
      : super(key: key);

  final QuestionModel question;
  final String questions;

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

  _editQuestion(String id, AppProvider state) {
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
        state.editFacultyQuestion(
            id, _questionController.text.trim(), _answers);
      } else if (widget.questions == 's') {
        state.editSpecialityQuestion(
            id, _questionController.text.trim(), _answers);
      }
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Вопрос успешно изменён');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        String initValue = widget.questions == 'f' ? 'ФТК' : '..';
        String facSecondInitValue = Constants.quizFacAnswersList[0].toString();

        if (initValue == 'ФТК') {
          // initValue = state.facultiesShortNames[0];
        }
        state.dropdown1Value = initValue;
        state.dropdown2Value = initValue;
        state.dropdown3Value = initValue;
        state.dropdown4Value = initValue;
        state.dropdown5Value = initValue;
        if (widget.questions == 'f') {
          state.dropdown12Value = facSecondInitValue;
          state.dropdown22Value = facSecondInitValue;
          state.dropdown32Value = facSecondInitValue;
          state.dropdown42Value = facSecondInitValue;
          state.dropdown52Value = facSecondInitValue;
        } else {
          state.dropdown12Value = initValue;
          state.dropdown22Value = initValue;
          state.dropdown32Value = initValue;
          state.dropdown42Value = initValue;
          state.dropdown52Value = initValue;
        }

        List<String> values;

        if (widget.questions == 'f') {
          values = [
            initValue,
            initValue,
            initValue,
            initValue,
            initValue,
            facSecondInitValue,
            facSecondInitValue,
            facSecondInitValue,
            facSecondInitValue,
            facSecondInitValue,
          ];
        } else {
          values = [
            initValue,
            initValue,
            initValue,
            initValue,
            initValue,
            initValue,
            initValue,
            initValue,
            initValue,
            initValue,
          ];
        }
        for (var i = 0; i < widget.question.answers!.length; i++) {
          values[i] = widget.question.answers![i].values.first.first;
          if (widget.question.answers![i].values.first.length > 1) {
            values[i + 5] = widget.question.answers![i].values.first.last;
          }
        }

        state.dropdown1Value = values[0];
        state.dropdown2Value = values[1];
        state.dropdown3Value = values[2];
        state.dropdown4Value = values[3];
        state.dropdown5Value = values[4];
        state.dropdown12Value = values[5];
        state.dropdown22Value = values[6];
        state.dropdown32Value = values[7];
        state.dropdown42Value = values[8];
        state.dropdown52Value = values[9];

        List<TextEditingController> _answerControllersList = [
          _answer1Controller,
          _answer2Controller,
          _answer3Controller,
          _answer4Controller,
          _answer5Controller,
        ];

        _questionController.text = widget.question.question!;
        for (var i = 0; i < widget.question.answers!.length; i++) {
          _answerControllersList[i].text =
              widget.question.answers![i].keys.first;
        }

        final helpSpecSheet = <Map<String, String>>[
          {
            'Доминирование (D)':
                'Представитель этого типа стремится победить даже через конфликт. Он его не боится и даже зачастую сам становится инициатором «разборок». Если «Д» вдруг окажется побежденным, то потребует реванша, из которого теперь точно выйдет победителем. Эти качества делают людей «Д» лучшими партнерами в кризисных ситуациях. «Д» - энергичные и волевые, адаптируются в разных условиях, потому им просто на должностях, требующих быстрой реакции и смекалки.'
          },
          {
            'Убеждение (I)':
                'Представители этого типа всегда собирают вокруг себя одноклассников, ненавязчиво внедряют свою точку зрения, и те не замечают, как идут на поводу. «У» - душа компании, а главный «мотиватор» для них – признание. Все, что пришло «У» в голову, он тут же хочет воплотить в жизнь. Это качество дает «У» преимущества в должностях, предполагающих раскрутку проектов, особенно, когда дело нужно сдвинуть с мертвой точки. Их конек также креативность, изобретательность и любовь ко всему новому и оригинальному.'
          },
          {
            'Постоянство (S)':
                'Представители данного типа стараются сплотить команду и уже общими усилиями добиваться цели. «П» считает, что мир доброжелателен, и поэтому все за него сами сделают или проблема решиться сама собой. Такой человек стремиться к стабильности и постоянству, главный «мотиватор» для него – предсказуемость. Потому «П» аккуратный и даже педантичный исполнитель рутины. Также «П» - психолог: чутко относится к людям, поможет, посочувствует, даст совет (он будет не радикальным).'
          },
          {
            'Следование правилам (C)':
                'Представители данного типа замкнуты, не любят показывать эмоции, часто проводят время в одиночестве, ни за что не откроют свою душу, считают, что мир враждебен. Но именно недоверие к миру делает из них отличных «ревизоров». Наиболее хорошие результаты «C» показывает, работая индивидуально, - посторонние их сбивают с мысли и раздражают. «C» способны к анализу и логическому просчету возможных ходов, поэтому у них всегда есть план действий «на про запас». скрупулезность также их конек.'
          },
        ];

        final helpFacSheet = <Map<String, String>>[
          {
            'Выпадающее меню 1': 'Выбор факультета, к которому относится ответ',
          },
          {
            'Выпадающее меню 2': 'Выбор множителя (вес ответа)',
          }
        ];

        var helpSheet = widget.questions == 'f' ? helpFacSheet : helpSpecSheet;

        return Scaffold(
          appBar: AppBar(
            title: Text('Редактирование вопроса'),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...helpSheet
                                      .map(
                                        (item) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.keys.first,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5.0),
                                              child: Text(item.values.first),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(Icons.help_outline),
              )
            ],
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
                          if (widget.questions == 'f') {
                            state.removeFacultyQuestion(widget.question.id!);
                          } else if (widget.questions == 's') {
                            state.removeSpecialityQuestion(widget.question.id!);
                          }
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

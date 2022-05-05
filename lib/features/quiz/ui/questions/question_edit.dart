import 'package:bntu_app/features/quiz/ui/questions/question_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/edit_buttons_section.dart';
import '../../../../core/widgets/remove_item.dart';
import '../../provider/quiz_provider.dart';

class QuestionEdit extends StatefulWidget {
  const QuestionEdit({Key? key}) : super(key: key);

  @override
  _QuestionEditState createState() => _QuestionEditState();
}

class _QuestionEditState extends State<QuestionEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _editQuestion(String id, QuizProvider state) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Вопрос успешно изменён');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, state, child) {
        // var initValue = widget.questions == 'f' ? 'ФТК' : '..';
        // var facSecondInitValue = Constants.quizFacAnswersList[0].toString();

        // if (initValue == 'ФТК') {
        //   // initValue = state.facultiesShortNames[0];
        // }
        // state.dropdown1Value = initValue;
        // state.dropdown2Value = initValue;
        // state.dropdown3Value = initValue;
        // state.dropdown4Value = initValue;
        // state.dropdown5Value = initValue;
        // if (widget.questions == 'f') {
        //   state.dropdown12Value = facSecondInitValue;
        //   state.dropdown22Value = facSecondInitValue;
        //   state.dropdown32Value = facSecondInitValue;
        //   state.dropdown42Value = facSecondInitValue;
        //   state.dropdown52Value = facSecondInitValue;
        // } else {
        //   state.dropdown12Value = initValue;
        //   state.dropdown22Value = initValue;
        //   state.dropdown32Value = initValue;
        //   state.dropdown42Value = initValue;
        //   state.dropdown52Value = initValue;
        // }

        // List<String> values;

        // if (widget.questions == 'f') {
        //   values = [
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     facSecondInitValue,
        //     facSecondInitValue,
        //     facSecondInitValue,
        //     facSecondInitValue,
        //     facSecondInitValue,
        //   ];
        // } else {
        //   values = [
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //     initValue,
        //   ];
        // }
        // for (var i = 0; i < widget.question.answers!.length; i++) {
        //   values[i] = widget.question.answers![i].values.first.first;
        //   if (widget.question.answers![i].values.first.length > 1) {
        //     values[i + 5] = widget.question.answers![i].values.first.last;
        //   }
        // }

        // state.dropdown1Value = values[0];
        // state.dropdown2Value = values[1];
        // state.dropdown3Value = values[2];
        // state.dropdown4Value = values[3];
        // state.dropdown5Value = values[4];
        // state.dropdown12Value = values[5];
        // state.dropdown22Value = values[6];
        // state.dropdown32Value = values[7];
        // state.dropdown42Value = values[8];
        // state.dropdown52Value = values[9];

        // var _answerControllersList = <TextEditingController>[
        //   _answer1Controller,
        //   _answer2Controller,
        //   _answer3Controller,
        //   _answer4Controller,
        //   _answer5Controller,
        // ];

        // _questionController.text = widget.question.question!;
        // for (var i = 0; i < widget.question.answers!.length; i++) {
        //   _answerControllersList[i].text =
        //       widget.question.answers![i].keys.first;
        // }

        // final helpSpecSheet = <Map<String, String>>[
        //   {
        //     'Доминирование (D)':
        //         'Представитель этого типа стремится победить даже через конфликт. Он его не боится и даже зачастую сам становится инициатором «разборок». Если «Д» вдруг окажется побежденным, то потребует реванша, из которого теперь точно выйдет победителем. Эти качества делают людей «Д» лучшими партнерами в кризисных ситуациях. «Д» - энергичные и волевые, адаптируются в разных условиях, потому им просто на должностях, требующих быстрой реакции и смекалки.'
        //   },
        //   {
        //     'Убеждение (I)':
        //         'Представители этого типа всегда собирают вокруг себя одноклассников, ненавязчиво внедряют свою точку зрения, и те не замечают, как идут на поводу. «У» - душа компании, а главный «мотиватор» для них – признание. Все, что пришло «У» в голову, он тут же хочет воплотить в жизнь. Это качество дает «У» преимущества в должностях, предполагающих раскрутку проектов, особенно, когда дело нужно сдвинуть с мертвой точки. Их конек также креативность, изобретательность и любовь ко всему новому и оригинальному.'
        //   },
        //   {
        //     'Постоянство (S)':
        //         'Представители данного типа стараются сплотить команду и уже общими усилиями добиваться цели. «П» считает, что мир доброжелателен, и поэтому все за него сами сделают или проблема решиться сама собой. Такой человек стремиться к стабильности и постоянству, главный «мотиватор» для него – предсказуемость. Потому «П» аккуратный и даже педантичный исполнитель рутины. Также «П» - психолог: чутко относится к людям, поможет, посочувствует, даст совет (он будет не радикальным).'
        //   },
        //   {
        //     'Следование правилам (C)':
        //         'Представители данного типа замкнуты, не любят показывать эмоции, часто проводят время в одиночестве, ни за что не откроют свою душу, считают, что мир враждебен. Но именно недоверие к миру делает из них отличных «ревизоров». Наиболее хорошие результаты «C» показывает, работая индивидуально, - посторонние их сбивают с мысли и раздражают. «C» способны к анализу и логическому просчету возможных ходов, поэтому у них всегда есть план действий «на про запас». скрупулезность также их конек.'
        //   },
        // ];

        // final helpFacSheet = <Map<String, String>>[
        //   {
        //     'Выпадающее меню 1': 'Выбор факультета, к которому относится ответ',
        //   },
        //   {
        //     'Выпадающее меню 2': 'Выбор множителя (вес ответа)',
        //   }
        // ];

        // var helpSheet = widget.questions == 'f' ? helpFacSheet : helpSpecSheet;

        return Scaffold(
          appBar: AppBar(
            title: Text('Редактирование вопроса'),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       showModalBottomSheet(
            //           context: context,
            //           builder: (context) {
            //             return Container(
            //               child: Padding(
            //                 padding: const EdgeInsets.all(10.0),
            //                 child: SingleChildScrollView(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       ...helpSheet
            //                           .map(
            //                             (item) => Column(
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               children: [
            //                                 Text(
            //                                   item.keys.first,
            //                                   style: TextStyle(fontSize: 20),
            //                                 ),
            //                                 Padding(
            //                                   padding: const EdgeInsets.only(
            //                                       bottom: 5.0),
            //                                   child: Text(item.values.first),
            //                                 ),
            //                               ],
            //                             ),
            //                           )
            //                           .toList(),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           });
            //     },
            //     icon: Icon(Icons.help_outline),
            //   )
            // ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: QuestionForm(
                    formKey: _formKey,
                    questionModel: state.questionInEdit!,
                  ),
                ),
              ),
              EditButtonsSection(
                onEditPressed: () {
                  state.editQuestion();

                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: 'Вопрос успешно изменён');
                },
                onRemovePressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RemoveItem(
                        itemName: 'вопрос',
                        onRemovePressed: () {
                          state.removeQuestion();

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

import 'package:bntu_app/features/quiz/ui/questions/question_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/edit_buttons_section.dart';
import '../../../../core/widgets/remove_item.dart';
import '../../provider/quiz_provider.dart';

class QuestionEdit extends StatelessWidget {
  const QuestionEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Consumer<QuizProvider>(
      builder: (context, state, child) {
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
                  ),
                ),
              ),
              EditButtonsSection(
                onEditPressed: () {
                  if (_formKey.currentState!.validate()) {
                    state.editQuestion();

                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: 'Вопрос успешно изменён');
                  }
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

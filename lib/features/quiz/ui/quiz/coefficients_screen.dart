import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/custom_text_field.dart';

class CoefficientsScreen extends StatefulWidget {
  const CoefficientsScreen({Key? key}) : super(key: key);

  @override
  State<CoefficientsScreen> createState() => _CoefficientsScreenState();
}

class _CoefficientsScreenState extends State<CoefficientsScreen> {
  final _coeffFormKey = GlobalKey<FormState>();
  final coeffController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer<QuizProvider>(builder: (context, state, child) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Form(
                        key: _coeffFormKey,
                        child: CustomTextFormField(
                          controller: coeffController,
                          validator: (value) {
                            if (value == '') {
                              return 'Введите коэффициент';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          labelText: 'Коэфф.',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_coeffFormKey.currentState!.validate()) {
                          state.addCoeff(coeff: coeffController.text);
                          coeffController.text = '';
                        }
                      },
                      child: Text('Добавить'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Список коэффициентов'),
                Wrap(
                  children: [
                    for (var i = 0;
                        i < state.quizInEdit!.coefficients.length;
                        i++)
                      Chip(
                        label: Text(state.quizInEdit!.coefficients[i]),
                        onDeleted: () {
                          state.removeCoeff(index: i);
                        },
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CheckboxListTile(
                  value: state.quizInEdit!.needPrintResults,
                  onChanged: (value) {
                    state.changeNeedPrintResults(value: value!);
                  },
                  title: Text(
                      'Результаты выводятся по наиболее часто встречающемуся коэффициенту'),
                ),
                if (state.quizInEdit!.needPrintResults)
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.quizInEdit!.coeffResults.length,
                    itemBuilder: (context, index) {
                      return listTile(
                        state,
                        index,
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget listTile(QuizProvider state, int coeffIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(state.quizInEdit!.coeffResults[coeffIndex].name),
        for (var resultIndex = 0;
            resultIndex <
                state.quizInEdit!.coeffResults[coeffIndex].results.length;
            resultIndex++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: TextEditingController(
                      text: state.quizInEdit!.coeffResults[coeffIndex]
                          .results[resultIndex].speciality),
                  onChanged: (value) {
                    state.coeffResultChangeSpeciality(
                      coeffIndex: coeffIndex,
                      resultIndex: resultIndex,
                      value: value,
                    );
                  },
                  labelText: 'Специальность',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: TextEditingController(
                      text: state.quizInEdit!.coeffResults[coeffIndex]
                          .results[resultIndex].faculty),
                  onChanged: (value) {
                    state.coeffResultChangeFaculty(
                      coeffIndex: coeffIndex,
                      resultIndex: resultIndex,
                      value: value,
                    );
                  },
                  labelText: 'Факультет',
                ),
              ),
              IconButton(
                onPressed: () {
                  state.coeffResultRemove(
                      coeffIndex: coeffIndex, resultIndex: resultIndex);
                },
                icon: Icon(Icons.remove),
              ),
            ],
          ),
        IconButton(
          onPressed: () {
            state.coeffResultAddNew(coeffIndex: coeffIndex);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}

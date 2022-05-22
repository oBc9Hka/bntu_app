import 'package:bntu_app/core/widgets/remove_item.dart';
import 'package:bntu_app/features/specialties/domain/models/admission_model.dart';
import 'package:bntu_app/features/specialties/domain/models/admission_places.dart';
import 'package:bntu_app/features/specialties/domain/models/admission_results.dart';
import 'package:bntu_app/features/specialties/provider/specialties_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constants.dart';

class SpecialityForm extends StatelessWidget {
  const SpecialityForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  static Color mainColor = Constants.mainColor;

  void addNewAdmissionYearDialog(context, SpecialtiesProvider state) {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        final formKey = GlobalKey<FormState>();
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Введите год приёма'),
                Divider(
                  thickness: 2,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Год'),
                    validator: (value) {
                      if (value == '') return 'Введите год';
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Отмена'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          state.specialityInEdit.admissions = [
                            AdmissionResults(
                              year: controller.text.trim(),
                              places: AdmissionInfo(
                                day: AdmissionModel(),
                                correspondence: AdmissionModel(),
                              ),
                              scores: AdmissionInfo(
                                day: AdmissionModel(),
                                correspondence: AdmissionModel(),
                              ),
                            ),
                            ...state.specialityInEdit.admissions,
                          ];
                          state.specialityInEdit.admissions.sort(
                            (a, b) => b.year.compareTo(a.year),
                          );
                          state.notif();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Добавить'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpecialtiesProvider>(builder: (context, state, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  // TextFormField(
                  //   controller: _facultyBasedController,
                  //   decoration: const InputDecoration(
                  //       labelText: 'Аббревиатура факультета*'),
                  //   validator: (value) {
                  //     if (value == '') return 'Введите факультет';
                  //     return null;
                  //   },
                  // ),
                  TextFormField(
                    controller: TextEditingController(
                        text: state.specialityInEdit.name),
                    minLines: 1,
                    maxLines: 3,
                    onChanged: (value) {
                      state.specialityInEdit.name = value;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Название специальности*'),
                    validator: (value) {
                      if (value == '') return 'Введите название';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: TextEditingController(
                        text: state.specialityInEdit.number),
                    onChanged: (value) {
                      state.specialityInEdit.number = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Номер специальности*'),
                    validator: (value) {
                      if (value == '') return 'Введите номер';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: TextEditingController(
                        text: state.specialityInEdit.qualification),
                    onChanged: (value) {
                      state.specialityInEdit.qualification = value;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Квалификация*'),
                    validator: (value) {
                      if (value == '') return 'Введите квалификацию';
                      return null;
                    },
                  ),

                  ExpansionTile(
                    title: Text(
                      'Длительность обучения',
                      style: TextStyle(color: mainColor),
                    ),
                    children: [
                      TextFormField(
                        controller: TextEditingController(
                            text:
                                state.specialityInEdit.trainingDurationDayFull),
                        onChanged: (value) {
                          state.specialityInEdit.trainingDurationDayFull =
                              value;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Дневное полное'),
                      ),
                      TextFormField(
                        controller: TextEditingController(
                            text: state
                                .specialityInEdit.trainingDurationDayShort),
                        onChanged: (value) {
                          state.specialityInEdit.trainingDurationDayShort =
                              value;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Дневное сокращённое'),
                      ),
                      TextFormField(
                        controller: TextEditingController(
                            text: state.specialityInEdit
                                .trainingDurationCorrespondenceFull),
                        onChanged: (value) {
                          state.specialityInEdit
                              .trainingDurationCorrespondenceFull = value;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Заочное полное'),
                      ),
                      TextFormField(
                        controller: TextEditingController(
                            text: state.specialityInEdit
                                .trainingDurationCorrespondenceShort),
                        onChanged: (value) {
                          state.specialityInEdit
                              .trainingDurationCorrespondenceShort = value;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Заочное сокращённое'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Вступительные исп. полное',
                      style: TextStyle(color: mainColor),
                    ),
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            state.specialityInEdit.entranceTestsFull.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: TextEditingController(
                                      text: state.specialityInEdit
                                          .entranceTestsFull[index]),
                                  onChanged: (value) {
                                    state.specialityInEdit
                                        .entranceTestsFull[index] = value;
                                  },
                                  decoration: InputDecoration(
                                      labelText: '№${index + 1}'),
                                  validator: (value) {
                                    if (value == '') return 'Введите значение';
                                    return null;
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  state.specialityInEdit.entranceTestsFull
                                      .removeAt(index);
                                  state.notif();
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ],
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          state.specialityInEdit.entranceTestsFull = [
                            ...state.specialityInEdit.entranceTestsFull,
                            '',
                          ];
                          state.notif();
                        },
                        child: Text('Добавить'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Вступительные исп. сокращенное',
                      style: TextStyle(color: mainColor),
                    ),
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.specialityInEdit.entranceShort.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: TextEditingController(
                                      text: state.specialityInEdit
                                          .entranceShort[index]),
                                  onChanged: (value) {
                                    state.specialityInEdit
                                        .entranceShort[index] = value;
                                  },
                                  decoration: InputDecoration(
                                      labelText: '№${index + 1}'),
                                  validator: (value) {
                                    if (value == '') return 'Введите значение';
                                    return null;
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  state.specialityInEdit.entranceShort
                                      .removeAt(index);
                                  state.notif();
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ],
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          state.specialityInEdit.entranceShort = [
                            ...state.specialityInEdit.entranceShort,
                            '',
                          ];
                          state.notif();
                        },
                        child: Text('Добавить'),
                      ),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: () {
                      addNewAdmissionYearDialog(context, state);
                    },
                    child: Text('Добавить год приема'),
                  ),

                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.specialityInEdit.admissions.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: ExpansionTile(
                              title: Text(
                                state.specialityInEdit.admissions[index].year,
                                style: TextStyle(color: mainColor),
                              ),
                              children: [
                                ExpansionTile(
                                  title: Text('План приема'),
                                  children: [
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .day
                                              .fullBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Бюджет дневное'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .places.day.fullBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .day
                                              .shortBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Бюджет дневное сокращённое'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .places.day.shortBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .correspondence
                                              .fullBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Бюджет заочное'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .places
                                            .correspondence
                                            .fullBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .correspondence
                                              .shortBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Бюджет заочное сокращённое'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .places
                                            .correspondence
                                            .shortBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .day
                                              .fullPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Платное дневное'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .places.day.fullPaid = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .day
                                              .shortPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Платное дневное сокращённое'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .places.day.shortPaid = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .correspondence
                                              .fullPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Платное заочное'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .places
                                            .correspondence
                                            .fullPaid = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .places
                                              .correspondence
                                              .shortPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Платное заочное сокращённое'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .places
                                            .correspondence
                                            .shortPaid = value;
                                      },
                                    ),
                                  ],
                                ),
                                ExpansionTile(
                                  title: Text(
                                    'Проходные баллы',
                                  ),
                                  children: [
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .day
                                              .fullBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Бюджет дневное'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .scores.day.fullBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .day
                                              .shortBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Бюджет дневное сокращённое'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .scores.day.shortBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .correspondence
                                              .fullBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Бюджет заочное'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .scores
                                            .correspondence
                                            .fullBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .correspondence
                                              .shortBudget),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Бюджет заочное сокращённое'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .scores
                                            .correspondence
                                            .shortBudget = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .day
                                              .fullPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Платное дневное'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .scores.day.fullPaid = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .day
                                              .shortPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Платное дневное сокращённое'),
                                      onChanged: (value) {
                                        state.specialityInEdit.admissions[index]
                                            .scores.day.shortPaid = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .correspondence
                                              .fullPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Платное заочное'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .scores
                                            .correspondence
                                            .fullPaid = value;
                                      },
                                    ),
                                    TextFormField(
                                      controller: TextEditingController(
                                          text: state
                                              .specialityInEdit
                                              .admissions[index]
                                              .scores
                                              .correspondence
                                              .shortPaid),
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Платное заочное сокращённое'),
                                      onChanged: (value) {
                                        state
                                            .specialityInEdit
                                            .admissions[index]
                                            .scores
                                            .correspondence
                                            .shortPaid = value;
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return RemoveItem(
                                    itemName: 'год приема',
                                    onRemovePressed: () {
                                      state.specialityInEdit.admissions
                                          .removeAt(index);
                                      state.notif();
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ],
                      );
                    },
                  ),

                  TextFormField(
                    controller: TextEditingController(
                        text: state.specialityInEdit.about),
                    onChanged: (value) {
                      state.specialityInEdit.about = value;
                    },
                    decoration: const InputDecoration(labelText: 'Описание*'),
                    validator: (value) {
                      if (value == '') return 'Введите описание';
                      return null;
                    },
                    minLines: 1,
                    maxLines: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

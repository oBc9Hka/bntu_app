import 'package:bntu_app/features/specialties/domain/models/admission_model.dart';
import 'package:bntu_app/features/specialties/domain/models/admission_results.dart';
import 'package:bntu_app/features/specialties/domain/models/speciality_model.dart';
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

  Widget _expandedTileAdmission(
    int year,
    dynamic c1,
    dynamic c2,
    dynamic c3,
    dynamic c4,
    dynamic c5,
    dynamic c6,
    dynamic c7,
    dynamic c8,
  ) {
    return ExpansionTile(
      title: Text(
        'План приёма $year',
        style: TextStyle(color: mainColor),
      ),
      children: [
        TextFormField(
          controller: c1,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Бюджет дневное'),
        ),
        TextFormField(
          controller: c2,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Бюджет дневное сокращённое'),
        ),
        TextFormField(
          controller: c5,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Бюджет заочное'),
        ),
        TextFormField(
          controller: c6,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Бюджет заочное сокращённое'),
        ),
        TextFormField(
          controller: c3,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Платное дневное'),
        ),
        TextFormField(
          controller: c4,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Платное дневное сокращённое'),
        ),
        TextFormField(
          controller: c7,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Платное заочное'),
        ),
        TextFormField(
          controller: c8,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Платное заочное сокращённое'),
        ),
      ],
    );
  }

  Widget _expandedTilePassScore(
    int year,
    dynamic c1,
    dynamic c2,
    dynamic c3,
    dynamic c4,
    dynamic c5,
    dynamic c6,
    dynamic c7,
    dynamic c8,
  ) {
    return ExpansionTile(
      title: Text(
        'Проходные баллы $year',
        style: TextStyle(color: mainColor),
      ),
      children: [
        TextFormField(
          controller: c1,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Бюджет дневное'),
        ),
        TextFormField(
          controller: c2,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Бюджет дневное сокращённое'),
        ),
        TextFormField(
          controller: c5,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Бюджет заочное'),
        ),
        TextFormField(
          controller: c6,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Бюджет заочное сокращённое'),
        ),
        TextFormField(
          controller: c3,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Платное дневное'),
        ),
        TextFormField(
          controller: c4,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Платное дневное сокращённое'),
        ),
        TextFormField(
          controller: c7,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Платное заочное'),
        ),
        TextFormField(
          controller: c8,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: 'Платное заочное сокращённое'),
        ),
      ],
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
                                      text: state.specialityInEdit.name),
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
                                      text: state.specialityInEdit.name),
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
                      state.specialityInEdit.admissions = [
                        ...state.specialityInEdit.admissions,
                        AdmissionResults(year: ''),
                      ];
                      state.notif();
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
                          IconButton(
                            onPressed: () {
                              state.specialityInEdit.admissions.removeAt(index);
                              state.notif();
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

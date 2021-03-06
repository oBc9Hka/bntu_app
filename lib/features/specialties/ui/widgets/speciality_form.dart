import 'package:bntu_app/features/faculties/domain/models/faculty_model.dart';
import 'package:bntu_app/features/specialties/domain/models/speciality_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class SpecialityForm extends StatelessWidget {
  const SpecialityForm({
    Key? key,
    this.faculty,
    this.speciality,
    required this.currentYear,
    required this.formKey,
    required this.facultyBasedController,
    required this.nameController,
    required this.numberController,
    required this.aboutController,
    required this.qualificationController,
    required this.trainingDurationDayFullController,
    required this.trainingDurationDayShortController,
    required this.trainingDurationCorrespondenceFullController,
    required this.trainingDurationCorrespondenceShortController,
    this.entranceTestsFullList,
    this.entranceShortList,
    required this.entranceTestsFull1Controller,
    required this.entranceTestsFull2Controller,
    required this.entranceTestsFull3Controller,
    required this.entranceTestsFull4Controller,
    required this.entranceTestsFull5Controller,
    required this.entranceShort1Controller,
    required this.entranceShort2Controller,
    required this.entranceShort3Controller,
    required this.entranceShort4Controller,
    required this.entranceShort5Controller,
    required this.admissionCurrentDayFullBudgetController,
    required this.admissionCurrentDayShortBudgetController,
    required this.admissionCurrentDayFullPaidController,
    required this.admissionCurrentDayShortPaidController,
    required this.admissionCurrentCorrespondenceFullBudgetController,
    required this.admissionCurrentCorrespondenceShortBudgetController,
    required this.admissionCurrentCorrespondenceFullPaidController,
    required this.admissionCurrentCorrespondenceShortPaidController,
    required this.passScorePrevYearDayFullBudgetController,
    required this.passScorePrevYearDayShortBudgetController,
    required this.passScorePrevYearDayFullPaidController,
    required this.passScorePrevYearDayShortPaidController,
    required this.passScorePrevYearCorrespondenceFullBudgetController,
    required this.passScorePrevYearCorrespondenceShortBudgetController,
    required this.passScorePrevYearCorrespondenceFullPaidController,
    required this.passScorePrevYearCorrespondenceShortPaidController,
    required this.admissionPrevYearDayFullBudgetController,
    required this.admissionPrevYearDayShortBudgetController,
    required this.admissionPrevYearDayFullPaidController,
    required this.admissionPrevYearDayShortPaidController,
    required this.admissionPrevYearCorrespondenceFullBudgetController,
    required this.admissionPrevYearCorrespondenceShortBudgetController,
    required this.admissionPrevYearCorrespondenceFullPaidController,
    required this.admissionPrevYearCorrespondenceShortPaidController,
    required this.passScoreBeforeLastYearDayFullBudgetController,
    required this.passScoreBeforeLastYearDayShortBudgetController,
    required this.passScoreBeforeLastYearDayFullPaidController,
    required this.passScoreBeforeLastYearDayShortPaidController,
    required this.passScoreBeforeLastYearCorrespondenceFullBudgetController,
    required this.passScoreBeforeLastYearCorrespondenceShortBudgetController,
    required this.passScoreBeforeLastYearCorrespondenceFullPaidController,
    required this.passScoreBeforeLastYearCorrespondenceShortPaidController,
  }) : super(key: key);

  final Faculty? faculty;
  final Speciality? speciality;
  final int currentYear;

  final GlobalKey<FormState> formKey;
  final TextEditingController facultyBasedController;
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController aboutController;
  final TextEditingController qualificationController;
  final TextEditingController trainingDurationDayFullController;
  final TextEditingController trainingDurationDayShortController;
  final TextEditingController trainingDurationCorrespondenceFullController;
  final TextEditingController trainingDurationCorrespondenceShortController;

  final List<String>? entranceTestsFullList;
  final List<String>? entranceShortList;
  final TextEditingController entranceTestsFull1Controller;
  final TextEditingController entranceTestsFull2Controller;
  final TextEditingController entranceTestsFull3Controller;
  final TextEditingController entranceTestsFull4Controller;
  final TextEditingController entranceTestsFull5Controller;

  final TextEditingController entranceShort1Controller;
  final TextEditingController entranceShort2Controller;
  final TextEditingController entranceShort3Controller;
  final TextEditingController entranceShort4Controller;
  final TextEditingController entranceShort5Controller;

  final TextEditingController admissionCurrentDayFullBudgetController;
  final TextEditingController admissionCurrentDayShortBudgetController;
  final TextEditingController admissionCurrentDayFullPaidController;
  final TextEditingController admissionCurrentDayShortPaidController;
  final TextEditingController
      admissionCurrentCorrespondenceFullBudgetController;
  final TextEditingController
      admissionCurrentCorrespondenceShortBudgetController;
  final TextEditingController admissionCurrentCorrespondenceFullPaidController;
  final TextEditingController admissionCurrentCorrespondenceShortPaidController;
  final TextEditingController passScorePrevYearDayFullBudgetController;
  final TextEditingController passScorePrevYearDayShortBudgetController;
  final TextEditingController passScorePrevYearDayFullPaidController;
  final TextEditingController passScorePrevYearDayShortPaidController;
  final TextEditingController
      passScorePrevYearCorrespondenceFullBudgetController;
  final TextEditingController
      passScorePrevYearCorrespondenceShortBudgetController;
  final TextEditingController passScorePrevYearCorrespondenceFullPaidController;
  final TextEditingController
      passScorePrevYearCorrespondenceShortPaidController;
  final TextEditingController admissionPrevYearDayFullBudgetController;
  final TextEditingController admissionPrevYearDayShortBudgetController;
  final TextEditingController admissionPrevYearDayFullPaidController;
  final TextEditingController admissionPrevYearDayShortPaidController;
  final TextEditingController
      admissionPrevYearCorrespondenceFullBudgetController;
  final TextEditingController
      admissionPrevYearCorrespondenceShortBudgetController;
  final TextEditingController admissionPrevYearCorrespondenceFullPaidController;
  final TextEditingController
      admissionPrevYearCorrespondenceShortPaidController;
  final TextEditingController passScoreBeforeLastYearDayFullBudgetController;
  final TextEditingController passScoreBeforeLastYearDayShortBudgetController;
  final TextEditingController passScoreBeforeLastYearDayFullPaidController;
  final TextEditingController passScoreBeforeLastYearDayShortPaidController;
  final TextEditingController
      passScoreBeforeLastYearCorrespondenceFullBudgetController;
  final TextEditingController
      passScoreBeforeLastYearCorrespondenceShortBudgetController;
  final TextEditingController
      passScoreBeforeLastYearCorrespondenceFullPaidController;
  final TextEditingController
      passScoreBeforeLastYearCorrespondenceShortPaidController;

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
        '???????? ???????????? $year',
        style: TextStyle(color: mainColor),
      ),
      children: [
        TextFormField(
          controller: c1,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '???????????? ??????????????'),
        ),
        TextFormField(
          controller: c2,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '???????????? ?????????????? ??????????????????????'),
        ),
        TextFormField(
          controller: c5,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '???????????? ??????????????'),
        ),
        TextFormField(
          controller: c6,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '???????????? ?????????????? ??????????????????????'),
        ),
        TextFormField(
          controller: c3,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '?????????????? ??????????????'),
        ),
        TextFormField(
          controller: c4,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '?????????????? ?????????????? ??????????????????????'),
        ),
        TextFormField(
          controller: c7,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '?????????????? ??????????????'),
        ),
        TextFormField(
          controller: c8,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '?????????????? ?????????????? ??????????????????????'),
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
        '?????????????????? ?????????? $year',
        style: TextStyle(color: mainColor),
      ),
      children: [
        TextFormField(
          controller: c1,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '???????????? ??????????????'),
        ),
        TextFormField(
          controller: c2,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '???????????? ?????????????? ??????????????????????'),
        ),
        TextFormField(
          controller: c5,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '???????????? ??????????????'),
        ),
        TextFormField(
          controller: c6,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '???????????? ?????????????? ??????????????????????'),
        ),
        TextFormField(
          controller: c3,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '?????????????? ??????????????'),
        ),
        TextFormField(
          controller: c4,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '?????????????? ?????????????? ??????????????????????'),
        ),
        TextFormField(
          controller: c7,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '?????????????? ??????????????'),
        ),
        TextFormField(
          controller: c8,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(labelText: '?????????????? ?????????????? ??????????????????????'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                //       labelText: '???????????????????????? ????????????????????*'),
                //   validator: (value) {
                //     if (value == '') return '?????????????? ??????????????????';
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: nameController,
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      labelText: '???????????????? ??????????????????????????*'),
                  validator: (value) {
                    if (value == '') return '?????????????? ????????????????';
                    return null;
                  },
                ),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: '?????????? ??????????????????????????*'),
                  validator: (value) {
                    if (value == '') return '?????????????? ??????????';
                    return null;
                  },
                ),
                TextFormField(
                  controller: qualificationController,
                  decoration: const InputDecoration(labelText: '????????????????????????*'),
                  validator: (value) {
                    if (value == '') return '?????????????? ????????????????????????';
                    return null;
                  },
                ),

                ExpansionTile(
                  title: Text(
                    '???????????????????????? ????????????????',
                    style: TextStyle(color: mainColor),
                  ),
                  children: [
                    TextFormField(
                      controller: trainingDurationDayFullController,
                      decoration:
                          const InputDecoration(labelText: '?????????????? ????????????'),
                    ),
                    TextFormField(
                      controller: trainingDurationDayShortController,
                      decoration: const InputDecoration(
                          labelText: '?????????????? ??????????????????????'),
                    ),
                    TextFormField(
                      controller: trainingDurationCorrespondenceFullController,
                      decoration:
                          const InputDecoration(labelText: '?????????????? ????????????'),
                    ),
                    TextFormField(
                      controller: trainingDurationCorrespondenceShortController,
                      decoration: const InputDecoration(
                          labelText: '?????????????? ??????????????????????'),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    '?????????????????????????? ??????. ????????????',
                    style: TextStyle(color: mainColor),
                  ),
                  children: [
                    TextFormField(
                      controller: entranceTestsFull1Controller,
                      decoration: const InputDecoration(labelText: '???1'),
                    ),
                    TextFormField(
                      controller: entranceTestsFull2Controller,
                      decoration: const InputDecoration(labelText: '???2'),
                    ),
                    TextFormField(
                      controller: entranceTestsFull3Controller,
                      decoration: const InputDecoration(labelText: '???3'),
                    ),
                    TextFormField(
                      controller: entranceTestsFull4Controller,
                      decoration: const InputDecoration(labelText: '???4'),
                    ),
                    TextFormField(
                      controller: entranceTestsFull5Controller,
                      decoration: const InputDecoration(labelText: '???5'),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    '?????????????????????????? ??????. ??????????????????????',
                    style: TextStyle(color: mainColor),
                  ),
                  children: [
                    TextFormField(
                      controller: entranceShort1Controller,
                      decoration: const InputDecoration(labelText: '???1'),
                    ),
                    TextFormField(
                      controller: entranceShort2Controller,
                      decoration: const InputDecoration(labelText: '???2'),
                    ),
                    TextFormField(
                      controller: entranceShort3Controller,
                      decoration: const InputDecoration(labelText: '???3'),
                    ),
                    TextFormField(
                      controller: entranceShort4Controller,
                      decoration: const InputDecoration(labelText: '???4'),
                    ),
                    TextFormField(
                      controller: entranceShort5Controller,
                      decoration: const InputDecoration(labelText: '???5'),
                    ),
                  ],
                ),

                // ???????? ???????????? ?????????????? ??????
                _expandedTileAdmission(
                  currentYear,
                  admissionCurrentDayFullBudgetController,
                  admissionCurrentDayShortBudgetController,
                  admissionCurrentDayFullPaidController,
                  admissionCurrentDayShortPaidController,
                  admissionCurrentCorrespondenceFullBudgetController,
                  admissionCurrentCorrespondenceShortBudgetController,
                  admissionCurrentCorrespondenceFullPaidController,
                  admissionCurrentCorrespondenceShortPaidController,
                ),
                // ?????????????????? ?????????? ?????????????? ??????
                _expandedTilePassScore(
                  currentYear - 1,
                  passScorePrevYearDayFullBudgetController,
                  passScorePrevYearDayShortBudgetController,
                  passScorePrevYearDayFullPaidController,
                  passScorePrevYearDayShortPaidController,
                  passScorePrevYearCorrespondenceFullBudgetController,
                  passScorePrevYearCorrespondenceShortBudgetController,
                  passScorePrevYearCorrespondenceFullPaidController,
                  passScorePrevYearCorrespondenceShortPaidController,
                ),
                //???????? ???????????? ?????????????? ??????
                _expandedTileAdmission(
                  currentYear - 1,
                  admissionPrevYearDayFullBudgetController,
                  admissionPrevYearDayShortBudgetController,
                  admissionPrevYearDayFullPaidController,
                  admissionPrevYearDayShortPaidController,
                  admissionPrevYearCorrespondenceFullBudgetController,
                  admissionPrevYearCorrespondenceShortBudgetController,
                  admissionPrevYearCorrespondenceFullPaidController,
                  admissionPrevYearCorrespondenceShortPaidController,
                ),
                //?????????????????? ?????????? ?????????????????????? ??????
                _expandedTilePassScore(
                  currentYear - 2,
                  passScoreBeforeLastYearDayFullBudgetController,
                  passScoreBeforeLastYearDayShortBudgetController,
                  passScoreBeforeLastYearDayFullPaidController,
                  passScoreBeforeLastYearDayShortPaidController,
                  passScoreBeforeLastYearCorrespondenceFullBudgetController,
                  passScoreBeforeLastYearCorrespondenceShortBudgetController,
                  passScoreBeforeLastYearCorrespondenceFullPaidController,
                  passScoreBeforeLastYearCorrespondenceShortPaidController,
                ),

                TextFormField(
                  controller: aboutController,
                  decoration: const InputDecoration(labelText: '????????????????*'),
                  validator: (value) {
                    if (value == '') return '?????????????? ????????????????';
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
  }
}

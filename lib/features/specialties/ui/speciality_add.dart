import 'package:bntu_app/features/faculties/domain/models/faculty_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/add_buttons_section.dart';
import '../provider/specialties_provider.dart';
import 'widgets/speciality_form.dart';

class SpecialityAdd extends StatefulWidget {
  const SpecialityAdd({Key? key, required this.faculty}) : super(key: key);
  final Faculty faculty;

  @override
  _SpecialityAddState createState() => _SpecialityAddState();
}

class _SpecialityAddState extends State<SpecialityAdd> {
  final TextEditingController _facultyBasedController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _trainingDurationDayFullController =
      TextEditingController();
  final TextEditingController _trainingDurationDayShortController =
      TextEditingController();
  final TextEditingController _trainingDurationCorrespondenceFullController =
      TextEditingController();
  final TextEditingController _trainingDurationCorrespondenceShortController =
      TextEditingController();

  final List<String> _entranceTestsFullList = [];
  final List<String> _entranceShortList = [];
  final TextEditingController _entranceTestsFull1Controller =
      TextEditingController();
  final TextEditingController _entranceTestsFull2Controller =
      TextEditingController();
  final TextEditingController _entranceTestsFull3Controller =
      TextEditingController();
  final TextEditingController _entranceTestsFull4Controller =
      TextEditingController();
  final TextEditingController _entranceTestsFull5Controller =
      TextEditingController();

  final TextEditingController _entranceShort1Controller =
      TextEditingController();
  final TextEditingController _entranceShort2Controller =
      TextEditingController();
  final TextEditingController _entranceShort3Controller =
      TextEditingController();
  final TextEditingController _entranceShort4Controller =
      TextEditingController();
  final TextEditingController _entranceShort5Controller =
      TextEditingController();

  final TextEditingController _admissionCurrentDayFullBudgetController =
      TextEditingController();
  final TextEditingController _admissionCurrentDayShortBudgetController =
      TextEditingController();
  final TextEditingController _admissionCurrentDayFullPaidController =
      TextEditingController();
  final TextEditingController _admissionCurrentDayShortPaidController =
      TextEditingController();
  final TextEditingController
      _admissionCurrentCorrespondenceFullBudgetController =
      TextEditingController();
  final TextEditingController
      _admissionCurrentCorrespondenceShortBudgetController =
      TextEditingController();
  final TextEditingController
      _admissionCurrentCorrespondenceFullPaidController =
      TextEditingController();
  final TextEditingController
      _admissionCurrentCorrespondenceShortPaidController =
      TextEditingController();
  final TextEditingController _passScorePrevYearDayFullBudgetController =
      TextEditingController();
  final TextEditingController _passScorePrevYearDayShortBudgetController =
      TextEditingController();
  final TextEditingController _passScorePrevYearDayFullPaidController =
      TextEditingController();
  final TextEditingController _passScorePrevYearDayShortPaidController =
      TextEditingController();
  final TextEditingController
      _passScorePrevYearCorrespondenceFullBudgetController =
      TextEditingController();
  final TextEditingController
      _passScorePrevYearCorrespondenceShortBudgetController =
      TextEditingController();
  final TextEditingController
      _passScorePrevYearCorrespondenceFullPaidController =
      TextEditingController();
  final TextEditingController
      _passScorePrevYearCorrespondenceShortPaidController =
      TextEditingController();
  final TextEditingController _admissionPrevYearDayFullBudgetController =
      TextEditingController();
  final TextEditingController _admissionPrevYearDayShortBudgetController =
      TextEditingController();
  final TextEditingController _admissionPrevYearDayFullPaidController =
      TextEditingController();
  final TextEditingController _admissionPrevYearDayShortPaidController =
      TextEditingController();
  final TextEditingController
      _admissionPrevYearCorrespondenceFullBudgetController =
      TextEditingController();
  final TextEditingController
      _admissionPrevYearCorrespondenceShortBudgetController =
      TextEditingController();
  final TextEditingController
      _admissionPrevYearCorrespondenceFullPaidController =
      TextEditingController();
  final TextEditingController
      _admissionPrevYearCorrespondenceShortPaidController =
      TextEditingController();
  final TextEditingController _passScoreBeforeLastYearDayFullBudgetController =
      TextEditingController();
  final TextEditingController _passScoreBeforeLastYearDayShortBudgetController =
      TextEditingController();
  final TextEditingController _passScoreBeforeLastYearDayFullPaidController =
      TextEditingController();
  final TextEditingController _passScoreBeforeLastYearDayShortPaidController =
      TextEditingController();
  final TextEditingController
      _passScoreBeforeLastYearCorrespondenceFullBudgetController =
      TextEditingController();
  final TextEditingController
      _passScoreBeforeLastYearCorrespondenceShortBudgetController =
      TextEditingController();
  final TextEditingController
      _passScoreBeforeLastYearCorrespondenceFullPaidController =
      TextEditingController();
  final TextEditingController
      _passScoreBeforeLastYearCorrespondenceShortPaidController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _getFullEntranceList(
    String first,
    String second,
    String third,
    String fourth,
    String fifth,
  ) {
    if (first != '') _entranceTestsFullList.add(first);
    if (second != '') _entranceTestsFullList.add(second);
    if (third != '') _entranceTestsFullList.add(third);
    if (fourth != '') _entranceTestsFullList.add(fourth);
    if (fifth != '') _entranceTestsFullList.add(fifth);
    print(_entranceTestsFullList);
  }

  void _getShortEntranceList(
    String first,
    String second,
    String third,
    String fourth,
    String fifth,
  ) {
    if (first != '') _entranceShortList.add(first);
    if (second != '') _entranceShortList.add(second);
    if (third != '') _entranceShortList.add(third);
    if (fourth != '') _entranceShortList.add(fourth);
    if (fifth != '') _entranceShortList.add(fifth);
  }

  void _addSpeciality(SpecialtiesProvider state) {
    if (_formKey.currentState!.validate()) {
      _getFullEntranceList(
          _entranceTestsFull1Controller.text,
          _entranceTestsFull2Controller.text,
          _entranceTestsFull3Controller.text,
          _entranceTestsFull4Controller.text,
          _entranceTestsFull5Controller.text);
      _getShortEntranceList(
          _entranceShort1Controller.text,
          _entranceShort2Controller.text,
          _entranceShort3Controller.text,
          _entranceShort4Controller.text,
          _entranceShort5Controller.text);

      state.addSpeciality(
        // _facultyBasedController.text,
        widget.faculty.shortName,
        _nameController.text,
        _numberController.text,
        _aboutController.text,
        _qualificationController.text,
        _trainingDurationDayFullController.text.trim(),
        _trainingDurationDayShortController.text.trim(),
        _trainingDurationCorrespondenceFullController.text.trim(),
        _trainingDurationCorrespondenceShortController.text.trim(),
        _entranceTestsFullList,
        _entranceShortList,
        _admissionCurrentDayFullBudgetController.text,
        _admissionCurrentDayShortBudgetController.text,
        _admissionCurrentDayFullPaidController.text,
        _admissionCurrentDayShortPaidController.text,
        _admissionCurrentCorrespondenceFullBudgetController.text,
        _admissionCurrentCorrespondenceShortBudgetController.text,
        _admissionCurrentCorrespondenceFullPaidController.text,
        _admissionCurrentCorrespondenceShortPaidController.text,
        _passScorePrevYearDayFullBudgetController.text,
        _passScorePrevYearDayShortBudgetController.text,
        _passScorePrevYearDayFullPaidController.text,
        _passScorePrevYearDayShortPaidController.text,
        _passScorePrevYearCorrespondenceFullBudgetController.text,
        _passScorePrevYearCorrespondenceShortBudgetController.text,
        _passScorePrevYearCorrespondenceFullPaidController.text,
        _passScorePrevYearCorrespondenceShortPaidController.text,
        _admissionPrevYearDayFullBudgetController.text,
        _admissionPrevYearDayShortBudgetController.text,
        _admissionPrevYearDayFullPaidController.text,
        _admissionPrevYearDayShortPaidController.text,
        _admissionPrevYearCorrespondenceFullBudgetController.text,
        _admissionPrevYearCorrespondenceShortBudgetController.text,
        _admissionPrevYearCorrespondenceFullPaidController.text,
        _admissionPrevYearCorrespondenceShortPaidController.text,
        _passScoreBeforeLastYearDayFullBudgetController.text,
        _passScoreBeforeLastYearDayShortBudgetController.text,
        _passScoreBeforeLastYearDayFullPaidController.text,
        _passScoreBeforeLastYearDayShortPaidController.text,
        _passScoreBeforeLastYearCorrespondenceFullBudgetController.text,
        _passScoreBeforeLastYearCorrespondenceShortBudgetController.text,
        _passScoreBeforeLastYearCorrespondenceFullPaidController.text,
        _passScoreBeforeLastYearCorrespondenceShortPaidController.text,
      );

      _formKey.currentState!.reset();
      Navigator.of(context).pop();
      state.initSpecialties();
      Fluttertoast.showToast(msg: 'Специальность успешно добавлена');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление специальности'),
      ),
      body: Consumer<SpecialtiesProvider>(
        builder: (context, state, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SpecialityForm(
                      faculty: widget.faculty,
                      formKey: _formKey,
                      currentYear: int.parse(state.currentAdmissionYear),
                      facultyBasedController: _facultyBasedController,
                      nameController: _nameController,
                      numberController: _numberController,
                      aboutController: _aboutController,
                      qualificationController: _qualificationController,
                      trainingDurationDayFullController:
                          _trainingDurationDayFullController,
                      trainingDurationDayShortController:
                          _trainingDurationDayShortController,
                      trainingDurationCorrespondenceFullController:
                          _trainingDurationCorrespondenceFullController,
                      trainingDurationCorrespondenceShortController:
                          _trainingDurationCorrespondenceShortController,
                      entranceTestsFull1Controller:
                          _entranceTestsFull1Controller,
                      entranceTestsFull2Controller:
                          _entranceTestsFull2Controller,
                      entranceTestsFull3Controller:
                          _entranceTestsFull3Controller,
                      entranceTestsFull4Controller:
                          _entranceTestsFull4Controller,
                      entranceTestsFull5Controller:
                          _entranceTestsFull5Controller,
                      entranceShort1Controller: _entranceShort1Controller,
                      entranceShort2Controller: _entranceShort2Controller,
                      entranceShort3Controller: _entranceShort3Controller,
                      entranceShort4Controller: _entranceShort4Controller,
                      entranceShort5Controller: _entranceShort5Controller,
                      admissionCurrentDayFullBudgetController:
                          _admissionCurrentDayFullBudgetController,
                      admissionCurrentDayShortBudgetController:
                          _admissionCurrentDayShortBudgetController,
                      admissionCurrentDayFullPaidController:
                          _admissionCurrentDayFullPaidController,
                      admissionCurrentDayShortPaidController:
                          _admissionCurrentDayShortPaidController,
                      admissionCurrentCorrespondenceFullBudgetController:
                          _admissionCurrentCorrespondenceFullBudgetController,
                      admissionCurrentCorrespondenceShortBudgetController:
                          _admissionCurrentCorrespondenceShortBudgetController,
                      admissionCurrentCorrespondenceFullPaidController:
                          _admissionCurrentCorrespondenceFullPaidController,
                      admissionCurrentCorrespondenceShortPaidController:
                          _admissionCurrentCorrespondenceShortPaidController,
                      passScorePrevYearDayFullBudgetController:
                          _passScorePrevYearDayFullBudgetController,
                      passScorePrevYearDayShortBudgetController:
                          _passScorePrevYearDayShortBudgetController,
                      passScorePrevYearDayFullPaidController:
                          _passScorePrevYearDayFullPaidController,
                      passScorePrevYearDayShortPaidController:
                          _passScorePrevYearDayShortPaidController,
                      passScorePrevYearCorrespondenceFullBudgetController:
                          _passScorePrevYearCorrespondenceFullBudgetController,
                      passScorePrevYearCorrespondenceShortBudgetController:
                          _passScorePrevYearCorrespondenceShortBudgetController,
                      passScorePrevYearCorrespondenceFullPaidController:
                          _passScorePrevYearCorrespondenceFullPaidController,
                      passScorePrevYearCorrespondenceShortPaidController:
                          _passScorePrevYearCorrespondenceShortPaidController,
                      admissionPrevYearDayFullBudgetController:
                          _admissionPrevYearDayFullBudgetController,
                      admissionPrevYearDayShortBudgetController:
                          _admissionPrevYearDayShortBudgetController,
                      admissionPrevYearDayFullPaidController:
                          _admissionPrevYearDayFullPaidController,
                      admissionPrevYearDayShortPaidController:
                          _admissionPrevYearDayShortPaidController,
                      admissionPrevYearCorrespondenceFullBudgetController:
                          _admissionPrevYearCorrespondenceFullBudgetController,
                      admissionPrevYearCorrespondenceShortBudgetController:
                          _admissionPrevYearCorrespondenceShortBudgetController,
                      admissionPrevYearCorrespondenceFullPaidController:
                          _admissionPrevYearCorrespondenceFullPaidController,
                      admissionPrevYearCorrespondenceShortPaidController:
                          _admissionPrevYearCorrespondenceShortPaidController,
                      passScoreBeforeLastYearDayFullBudgetController:
                          _passScoreBeforeLastYearDayFullBudgetController,
                      passScoreBeforeLastYearDayShortBudgetController:
                          _passScoreBeforeLastYearDayShortBudgetController,
                      passScoreBeforeLastYearDayFullPaidController:
                          _passScoreBeforeLastYearDayFullPaidController,
                      passScoreBeforeLastYearDayShortPaidController:
                          _passScoreBeforeLastYearDayShortPaidController,
                      passScoreBeforeLastYearCorrespondenceFullBudgetController:
                          _passScoreBeforeLastYearCorrespondenceFullBudgetController,
                      passScoreBeforeLastYearCorrespondenceShortBudgetController:
                          _passScoreBeforeLastYearCorrespondenceShortBudgetController,
                      passScoreBeforeLastYearCorrespondenceFullPaidController:
                          _passScoreBeforeLastYearCorrespondenceFullPaidController,
                      passScoreBeforeLastYearCorrespondenceShortPaidController:
                          _passScoreBeforeLastYearCorrespondenceShortPaidController,
                    )
                  ],
                ),
              ),
              AddButtonsSection(onAddPressed: () {
                _addSpeciality(state);
              }),
            ],
          );
        },
      ),
    );
  }
}

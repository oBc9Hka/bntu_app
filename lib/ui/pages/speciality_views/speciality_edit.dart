import 'package:bntu_app/models/speciality_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/speciality_views/speciality_form.dart';
import 'package:bntu_app/ui/widgets/edit_buttons_section.dart';
import 'package:bntu_app/ui/widgets/remove_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SpecialityEdit extends StatefulWidget {
  const SpecialityEdit({Key? key, required this.speciality}) : super(key: key);
  final Speciality speciality;

  @override
  _SpecialityAddStEdit createState() => _SpecialityAddStEdit();
}

class _SpecialityAddStEdit extends State<SpecialityEdit> {
  TextEditingController _facultyBasedController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _trainingDurationDayFullController =
      TextEditingController();
  TextEditingController _trainingDurationDayShortController =
      TextEditingController();
  TextEditingController _trainingDurationCorrespondenceFullController =
      TextEditingController();
  TextEditingController _trainingDurationCorrespondenceShortController =
      TextEditingController();

  List<String> _entranceTestsFullList = [];
  List<String> _entranceShortList = [];
  TextEditingController _entranceTestsFull1Controller = TextEditingController();
  TextEditingController _entranceTestsFull2Controller = TextEditingController();
  TextEditingController _entranceTestsFull3Controller = TextEditingController();
  TextEditingController _entranceTestsFull4Controller = TextEditingController();
  TextEditingController _entranceTestsFull5Controller = TextEditingController();

  TextEditingController _entranceShort1Controller = TextEditingController();
  TextEditingController _entranceShort2Controller = TextEditingController();
  TextEditingController _entranceShort3Controller = TextEditingController();
  TextEditingController _entranceShort4Controller = TextEditingController();
  TextEditingController _entranceShort5Controller = TextEditingController();

  TextEditingController _admissionCurrentDayFullBudgetController =
      TextEditingController();
  TextEditingController _admissionCurrentDayShortBudgetController =
      TextEditingController();
  TextEditingController _admissionCurrentDayFullPaidController =
      TextEditingController();
  TextEditingController _admissionCurrentDayShortPaidController =
      TextEditingController();
  TextEditingController _admissionCurrentCorrespondenceFullBudgetController =
      TextEditingController();
  TextEditingController _admissionCurrentCorrespondenceShortBudgetController =
      TextEditingController();
  TextEditingController _admissionCurrentCorrespondenceFullPaidController =
      TextEditingController();
  TextEditingController _admissionCurrentCorrespondenceShortPaidController =
      TextEditingController();
  TextEditingController _passScorePrevYearDayFullBudgetController =
      TextEditingController();
  TextEditingController _passScorePrevYearDayShortBudgetController =
      TextEditingController();
  TextEditingController _passScorePrevYearDayFullPaidController =
      TextEditingController();
  TextEditingController _passScorePrevYearDayShortPaidController =
      TextEditingController();
  TextEditingController _passScorePrevYearCorrespondenceFullBudgetController =
      TextEditingController();
  TextEditingController _passScorePrevYearCorrespondenceShortBudgetController =
      TextEditingController();
  TextEditingController _passScorePrevYearCorrespondenceFullPaidController =
      TextEditingController();
  TextEditingController _passScorePrevYearCorrespondenceShortPaidController =
      TextEditingController();
  TextEditingController _admissionPrevYearDayFullBudgetController =
      TextEditingController();
  TextEditingController _admissionPrevYearDayShortBudgetController =
      TextEditingController();
  TextEditingController _admissionPrevYearDayFullPaidController =
      TextEditingController();
  TextEditingController _admissionPrevYearDayShortPaidController =
      TextEditingController();
  TextEditingController _admissionPrevYearCorrespondenceFullBudgetController =
      TextEditingController();
  TextEditingController _admissionPrevYearCorrespondenceShortBudgetController =
      TextEditingController();
  TextEditingController _admissionPrevYearCorrespondenceFullPaidController =
      TextEditingController();
  TextEditingController _admissionPrevYearCorrespondenceShortPaidController =
      TextEditingController();
  TextEditingController _passScoreBeforeLastYearDayFullBudgetController =
      TextEditingController();
  TextEditingController _passScoreBeforeLastYearDayShortBudgetController =
      TextEditingController();
  TextEditingController _passScoreBeforeLastYearDayFullPaidController =
      TextEditingController();
  TextEditingController _passScoreBeforeLastYearDayShortPaidController =
      TextEditingController();
  TextEditingController
      _passScoreBeforeLastYearCorrespondenceFullBudgetController =
      TextEditingController();
  TextEditingController
      _passScoreBeforeLastYearCorrespondenceShortBudgetController =
      TextEditingController();
  TextEditingController
      _passScoreBeforeLastYearCorrespondenceFullPaidController =
      TextEditingController();
  TextEditingController
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

  void _editSpeciality(String id, AppProvider state) {
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

      state.editSpeciality(
        _facultyBasedController.text,
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
        id,
      );

      _formKey.currentState!.reset();
      Navigator.of(context).pop();
      state.initSpecialties();
      Fluttertoast.showToast(msg: 'Специальность успешно изменена');
    }
  }

  void _removeSpeciality(String id, AppProvider state) {
    state.removeSpeciality(id);
    state.initSpecialties();
    Navigator.pop(context);
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Специальность успешно удалена');
  }

  @override
  Widget build(BuildContext context) {
    _facultyBasedController =
        TextEditingController(text: widget.speciality.facultyBased);
    _nameController = TextEditingController(text: widget.speciality.name);
    _numberController = TextEditingController(text: widget.speciality.number);
    _aboutController = TextEditingController(text: widget.speciality.about);
    _qualificationController =
        TextEditingController(text: widget.speciality.qualification);
    _trainingDurationDayFullController =
        TextEditingController(text: widget.speciality.trainingDurationDayFull);
    _trainingDurationDayShortController =
        TextEditingController(text: widget.speciality.trainingDurationDayShort);
    _trainingDurationCorrespondenceFullController = TextEditingController(
        text: widget.speciality.trainingDurationCorrespondenceFull);
    _trainingDurationCorrespondenceShortController = TextEditingController(
        text: widget.speciality.trainingDurationCorrespondenceShort);

    List? _entranceTestsFull = widget.speciality.entranceTestsFull;
    int _count = 0;
    String _entranceTestsFull1 = '';
    String _entranceTestsFull2 = '';
    String _entranceTestsFull3 = '';
    String _entranceTestsFull4 = '';
    String _entranceTestsFull5 = '';
    for (var e in _entranceTestsFull!) {
      ++_count;
      if (_count > 0 && _count < 2) {
        _entranceTestsFull1 = _entranceTestsFull[0] as String;
      }
      if (_count > 1 && _count < 3) {
        _entranceTestsFull2 = _entranceTestsFull[1] as String;
      }
      if (_count > 2 && _count < 4) {
        _entranceTestsFull3 = _entranceTestsFull[2] as String;
      }
      if (_count > 3 && _count < 5) {
        _entranceTestsFull4 = _entranceTestsFull[3] as String;
      }
      if (_count > 4 && _count < 6) {
        _entranceTestsFull5 = _entranceTestsFull[4] as String;
      }
    }

    List? _entranceTestsShort = widget.speciality.entranceShort;
    _count = 0;
    String _entranceTestsShort1 = '';
    String _entranceTestsShort2 = '';
    String _entranceTestsShort3 = '';
    String _entranceTestsShort4 = '';
    String _entranceTestsShort5 = '';
    for (var e in _entranceTestsShort!) {
      ++_count;
      if (_count == 1) {
        _entranceTestsShort1 = _entranceTestsShort[0] as String;
      }
      if (_count == 2) {
        _entranceTestsShort2 = _entranceTestsShort[1] as String;
      }
      if (_count == 3) {
        _entranceTestsShort3 = _entranceTestsShort[2] as String;
      }
      if (_count == 4) {
        _entranceTestsShort4 = _entranceTestsShort[3] as String;
      }
      if (_count == 5) {
        _entranceTestsShort5 = _entranceTestsShort[4] as String;
      }
    }

    _entranceTestsFull1Controller =
        TextEditingController(text: _entranceTestsFull1);
    _entranceTestsFull2Controller =
        TextEditingController(text: _entranceTestsFull2);
    _entranceTestsFull3Controller =
        TextEditingController(text: _entranceTestsFull3);
    _entranceTestsFull4Controller =
        TextEditingController(text: _entranceTestsFull4);
    _entranceTestsFull5Controller =
        TextEditingController(text: _entranceTestsFull5);
    _entranceShort1Controller =
        TextEditingController(text: _entranceTestsShort1);
    _entranceShort2Controller =
        TextEditingController(text: _entranceTestsShort2);
    _entranceShort3Controller =
        TextEditingController(text: _entranceTestsShort3);
    _entranceShort4Controller =
        TextEditingController(text: _entranceTestsShort4);
    _entranceShort5Controller =
        TextEditingController(text: _entranceTestsShort5);

    _admissionCurrentDayFullBudgetController = TextEditingController(
        text: widget.speciality.admissionCurrentDayFullBudget);
    _admissionCurrentDayShortBudgetController = TextEditingController(
        text: widget.speciality.admissionCurrentDayShortBudget);
    _admissionCurrentDayFullPaidController = TextEditingController(
        text: widget.speciality.admissionCurrentDayFullPaid);
    _admissionCurrentDayShortPaidController = TextEditingController(
        text: widget.speciality.admissionCurrentDayShortPaid);
    _admissionCurrentCorrespondenceFullBudgetController = TextEditingController(
        text: widget.speciality.admissionCurrentCorrespondenceFullBudget);
    _admissionCurrentCorrespondenceShortBudgetController =
        TextEditingController(
            text: widget.speciality.admissionCurrentCorrespondenceShortBudget);
    _admissionCurrentCorrespondenceFullPaidController = TextEditingController(
        text: widget.speciality.admissionCurrentCorrespondenceFullPaid);
    _admissionCurrentCorrespondenceShortPaidController = TextEditingController(
        text: widget.speciality.admissionCurrentCorrespondenceShortPaid);
    _passScorePrevYearDayFullBudgetController = TextEditingController(
        text: widget.speciality.passScorePrevYearDayFullBudget);
    _passScorePrevYearDayShortBudgetController = TextEditingController(
        text: widget.speciality.passScorePrevYearDayShortBudget);
    _passScorePrevYearDayFullPaidController = TextEditingController(
        text: widget.speciality.passScorePrevYearDayFullPaid);
    _passScorePrevYearDayShortPaidController = TextEditingController(
        text: widget.speciality.passScorePrevYearDayShortPaid);
    _passScorePrevYearCorrespondenceFullBudgetController =
        TextEditingController(
            text: widget.speciality.passScorePrevYearCorrespondenceFullBudget);
    _passScorePrevYearCorrespondenceShortBudgetController =
        TextEditingController(
            text: widget.speciality.passScorePrevYearCorrespondenceShortBudget);
    _passScorePrevYearCorrespondenceFullPaidController = TextEditingController(
        text: widget.speciality.passScorePrevYearCorrespondenceFullPaid);
    _passScorePrevYearCorrespondenceShortPaidController = TextEditingController(
        text: widget.speciality.passScorePrevYearCorrespondenceShortPaid);
    _admissionPrevYearDayFullBudgetController = TextEditingController(
        text: widget.speciality.admissionPrevYearDayFullBudget);
    _admissionPrevYearDayShortBudgetController = TextEditingController(
        text: widget.speciality.admissionPrevYearDayShortBudget);
    _admissionPrevYearDayFullPaidController = TextEditingController(
        text: widget.speciality.admissionPrevYearDayFullPaid);
    _admissionPrevYearDayShortPaidController = TextEditingController(
        text: widget.speciality.admissionPrevYearDayShortPaid);
    _admissionPrevYearCorrespondenceFullBudgetController =
        TextEditingController(
            text: widget.speciality.admissionPrevYearCorrespondenceFullBudget);
    _admissionPrevYearCorrespondenceShortBudgetController =
        TextEditingController(
            text: widget.speciality.admissionPrevYearCorrespondenceShortBudget);
    _admissionPrevYearCorrespondenceFullPaidController = TextEditingController(
        text: widget.speciality.admissionPrevYearCorrespondenceFullPaid);
    _admissionPrevYearCorrespondenceShortPaidController = TextEditingController(
        text: widget.speciality.admissionPrevYearCorrespondenceShortPaid);
    _passScoreBeforeLastYearDayFullBudgetController = TextEditingController(
        text: widget.speciality.passScoreBeforeLastYearDayFullBudget);
    _passScoreBeforeLastYearDayShortBudgetController = TextEditingController(
        text: widget.speciality.passScoreBeforeLastYearDayShortBudget);
    _passScoreBeforeLastYearDayFullPaidController = TextEditingController(
        text: widget.speciality.passScoreBeforeLastYearDayFullPaid);
    _passScoreBeforeLastYearDayShortPaidController = TextEditingController(
        text: widget.speciality.passScoreBeforeLastYearDayShortPaid);
    _passScoreBeforeLastYearCorrespondenceFullBudgetController =
        TextEditingController(
            text: widget
                .speciality.passScoreBeforeLastYearCorrespondenceFullBudget);
    _passScoreBeforeLastYearCorrespondenceShortBudgetController =
        TextEditingController(
            text: widget
                .speciality.passScoreBeforeLastYearCorrespondenceShortBudget);
    _passScoreBeforeLastYearCorrespondenceFullPaidController =
        TextEditingController(
            text: widget
                .speciality.passScoreBeforeLastYearCorrespondenceFullPaid);
    _passScoreBeforeLastYearCorrespondenceShortPaidController =
        TextEditingController(
            text: widget
                .speciality.passScoreBeforeLastYearCorrespondenceShortPaid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Изменение специальности'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, state, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SpecialityForm(
                      speciality: widget.speciality,
                      currentYear: int.parse(state.currentAdmissionYear),
                      formKey: _formKey,
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
              EditButtonsSection(
                onEditPressed: () {
                  _editSpeciality(widget.speciality.id.toString(), state);
                },
                onRemovePressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RemoveItem(
                        itemName: 'специальность',
                        onRemovePressed: () {
                          _removeSpeciality(
                              widget.speciality.id.toString(), state);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/speciality_views/speciality_form.dart';
import 'package:bntu_app/ui/widgets/add_buttons_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SpecialityAdd extends StatefulWidget {
  const SpecialityAdd({Key? key, required this.faculty}) : super(key: key);
  final Faculty faculty;

  @override
  _SpecialityAddState createState() => _SpecialityAddState();
}

class _SpecialityAddState extends State<SpecialityAdd> {
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

  void _addSpeciality(AppProvider state) {
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
              AddButtonsSection(onAddPressed: () {_addSpeciality(state);}),
            ],
          );
        },
      ),
    );
  }
}

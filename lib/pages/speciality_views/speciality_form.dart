import 'package:bntu_app/models/speciality_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SpecialityForm extends StatefulWidget {
  const SpecialityForm(
      {Key? key, this.speciality, this.faculty, required this.isEdit})
      : super(key: key);

  final QueryDocumentSnapshot<Object?>? faculty;
  final QueryDocumentSnapshot<Object?>? speciality;
  final bool isEdit;

  @override
  _SpecialityFormState createState() => _SpecialityFormState();
}

class _SpecialityFormState extends State<SpecialityForm> {
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
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);
  Speciality _speciality = Speciality();

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
    setState(() {});
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

  void _addSpeciality() {
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

      _speciality.addSpeciality(
        // _facultyBasedController.text,
        widget.faculty?['shortName'],
        _nameController.text,
        _numberController.text,
        _aboutController.text,
        _qualificationController.text,
        _trainingDurationDayFullController.text,
        _trainingDurationDayShortController.text,
        _trainingDurationCorrespondenceFullController.text,
        _trainingDurationCorrespondenceShortController.text,
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
      Fluttertoast.showToast(msg: 'Специальность успешно добавлена');
    }
  }

  void _editSpeciality(String id) {
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

      _speciality.editSpeciality(
        _facultyBasedController.text,
        _nameController.text,
        _numberController.text,
        _aboutController.text,
        _qualificationController.text,
        _trainingDurationDayFullController.text,
        _trainingDurationDayShortController.text,
        _trainingDurationCorrespondenceFullController.text,
        _trainingDurationCorrespondenceShortController.text,
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
      Fluttertoast.showToast(msg: 'Специальность успешно изменена');
    }
  }

  void _showAlertDialog(
      BuildContext context, QueryDocumentSnapshot<Object?>? item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 40,
            child: const Center(
                child: Text(
              'Хотите удалить специальность?',
              style: TextStyle(
                  fontSize:
                      18), //TODO: дообавить проверку намерения путём написания аббревиатуры
            )),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _speciality.removeSpeciality(item!.id);
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(msg: 'Специальность успешно удалена');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38),
              ),
              child: const Text(
                'Отмена',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _facultyBasedController =
          TextEditingController(text: widget.speciality!['facultyBased']);
      _nameController = TextEditingController(text: widget.speciality!['name']);
      _numberController =
          TextEditingController(text: widget.speciality!['number']);
      _aboutController =
          TextEditingController(text: widget.speciality!['about']);
      _qualificationController =
          TextEditingController(text: widget.speciality!['qualification']);
      _trainingDurationDayFullController = TextEditingController(
          text: widget.speciality!['trainingDurationDayFull']);
      _trainingDurationDayShortController = TextEditingController(
          text: widget.speciality!['trainingDurationDayShort']);
      _trainingDurationCorrespondenceFullController = TextEditingController(
          text: widget.speciality!['trainingDurationCorrespondenceFull']);
      _trainingDurationCorrespondenceShortController = TextEditingController(
          text: widget.speciality!['trainingDurationCorrespondenceShort']);

      List _entranceTestsFull = widget.speciality!['entranceTestsFull'];
      int _count = 0;
      String _entranceTestsFull1 = '';
      String _entranceTestsFull2 = '';
      String _entranceTestsFull3 = '';
      String _entranceTestsFull4 = '';
      String _entranceTestsFull5 = '';
      for (var e in _entranceTestsFull) {
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

      List _entranceTestsShort = widget.speciality!['entranceShort'];
      _count = 0;
      String _entranceTestsShort1 = '';
      String _entranceTestsShort2 = '';
      String _entranceTestsShort3 = '';
      String _entranceTestsShort4 = '';
      String _entranceTestsShort5 = '';
      for (var e in _entranceTestsShort) {
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
          text: widget.speciality!['admissionCurrentDayFullBudget']);
      _admissionCurrentDayShortBudgetController = TextEditingController(
          text: widget.speciality!['admissionCurrentDayShortBudget']);
      _admissionCurrentDayFullPaidController = TextEditingController(
          text: widget.speciality!['admissionCurrentDayFullPaid']);
      _admissionCurrentDayShortPaidController = TextEditingController(
          text: widget.speciality!['admissionCurrentDayShortPaid']);
      _admissionCurrentCorrespondenceFullBudgetController =
          TextEditingController(
              text: widget
                  .speciality!['admissionCurrentCorrespondenceFullBudget']);
      _admissionCurrentCorrespondenceShortBudgetController =
          TextEditingController(
              text: widget
                  .speciality!['admissionCurrentCorrespondenceShortBudget']);
      _admissionCurrentCorrespondenceFullPaidController = TextEditingController(
          text: widget.speciality!['admissionCurrentCorrespondenceFullPaid']);
      _admissionCurrentCorrespondenceShortPaidController =
          TextEditingController(
              text: widget
                  .speciality!['admissionCurrentCorrespondenceShortPaid']);
      _passScorePrevYearDayFullBudgetController = TextEditingController(
          text: widget.speciality!['passScorePrevYearDayFullBudget']);
      _passScorePrevYearDayShortBudgetController = TextEditingController(
          text: widget.speciality!['passScorePrevYearDayShortBudget']);
      _passScorePrevYearDayFullPaidController = TextEditingController(
          text: widget.speciality!['passScorePrevYearDayFullPaid']);
      _passScorePrevYearDayShortPaidController = TextEditingController(
          text: widget.speciality!['passScorePrevYearDayShortPaid']);
      _passScorePrevYearCorrespondenceFullBudgetController =
          TextEditingController(
              text: widget
                  .speciality!['passScorePrevYearCorrespondenceFullBudget']);
      _passScorePrevYearCorrespondenceShortBudgetController =
          TextEditingController(
              text: widget
                  .speciality!['passScorePrevYearCorrespondenceShortBudget']);
      _passScorePrevYearCorrespondenceFullPaidController =
          TextEditingController(
              text: widget
                  .speciality!['passScorePrevYearCorrespondenceFullPaid']);
      _passScorePrevYearCorrespondenceShortPaidController =
          TextEditingController(
              text: widget
                  .speciality!['passScorePrevYearCorrespondenceShortPaid']);
      _admissionPrevYearDayFullBudgetController = TextEditingController(
          text: widget.speciality!['admissionPrevYearDayFullBudget']);
      _admissionPrevYearDayShortBudgetController = TextEditingController(
          text: widget.speciality!['admissionPrevYearDayShortBudget']);
      _admissionPrevYearDayFullPaidController = TextEditingController(
          text: widget.speciality!['admissionPrevYearDayFullPaid']);
      _admissionPrevYearDayShortPaidController = TextEditingController(
          text: widget.speciality!['admissionPrevYearDayShortPaid']);
      _admissionPrevYearCorrespondenceFullBudgetController =
          TextEditingController(
              text: widget
                  .speciality!['admissionPrevYearCorrespondenceFullBudget']);
      _admissionPrevYearCorrespondenceShortBudgetController =
          TextEditingController(
              text: widget
                  .speciality!['admissionPrevYearCorrespondenceShortBudget']);
      _admissionPrevYearCorrespondenceFullPaidController =
          TextEditingController(
              text: widget
                  .speciality!['admissionPrevYearCorrespondenceFullPaid']);
      _admissionPrevYearCorrespondenceShortPaidController =
          TextEditingController(
              text: widget
                  .speciality!['admissionPrevYearCorrespondenceShortPaid']);
      _passScoreBeforeLastYearDayFullBudgetController = TextEditingController(
          text: widget.speciality!['passScoreBeforeLastYearDayFullBudget']);
      _passScoreBeforeLastYearDayShortBudgetController = TextEditingController(
          text: widget.speciality!['passScoreBeforeLastYearDayShortBudget']);
      _passScoreBeforeLastYearDayFullPaidController = TextEditingController(
          text: widget.speciality!['passScoreBeforeLastYearDayFullPaid']);
      _passScoreBeforeLastYearDayShortPaidController = TextEditingController(
          text: widget.speciality!['passScoreBeforeLastYearDayShortPaid']);
      _passScoreBeforeLastYearCorrespondenceFullBudgetController =
          TextEditingController(
              text: widget.speciality![
                  'passScoreBeforeLastYearCorrespondenceFullBudget']);
      _passScoreBeforeLastYearCorrespondenceShortBudgetController =
          TextEditingController(
              text: widget.speciality![
                  'passScoreBeforeLastYearCorrespondenceShortBudget']);
      _passScoreBeforeLastYearCorrespondenceFullPaidController =
          TextEditingController(
              text: widget.speciality![
                  'passScoreBeforeLastYearCorrespondenceFullPaid']);
      _passScoreBeforeLastYearCorrespondenceShortPaidController =
          TextEditingController(
              text: widget.speciality![
                  'passScoreBeforeLastYearCorrespondenceShortPaid']);
    }

    return Column(
      children: [
        Form(
          key: _formKey,
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
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: 'Название специальности*'),
                validator: (value) {
                  if (value == '') return 'Введите название';
                  return null;
                },
              ),
              TextFormField(
                controller: _numberController,
                decoration:
                    const InputDecoration(labelText: 'Номер специальности*'),
                validator: (value) {
                  if (value == '') return 'Введите номер';
                  return null;
                },
              ),
              TextFormField(
                controller: _qualificationController,
                decoration: const InputDecoration(labelText: 'Квалификация*'),
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
                    controller: _trainingDurationDayFullController,
                    decoration:
                    const InputDecoration(labelText: 'Дневное полное'),
                  ),
                  TextFormField(
                    controller: _trainingDurationDayShortController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное сокращённое'),
                  ),
                  TextFormField(
                    controller: _trainingDurationCorrespondenceFullController,
                    decoration:
                    const InputDecoration(labelText: 'Заочное полное'),
                  ),
                  TextFormField(
                    controller:
                    _trainingDurationCorrespondenceShortController,
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
                  TextFormField(
                    controller: _entranceTestsFull1Controller,
                    decoration: const InputDecoration(labelText: '№1'),
                  ),
                  TextFormField(
                    controller: _entranceTestsFull2Controller,
                    decoration: const InputDecoration(labelText: '№2'),
                  ),
                  TextFormField(
                    controller: _entranceTestsFull3Controller,
                    decoration: const InputDecoration(labelText: '№3'),
                  ),
                  TextFormField(
                    controller: _entranceTestsFull4Controller,
                    decoration: const InputDecoration(labelText: '№4'),
                  ),
                  TextFormField(
                    controller: _entranceTestsFull5Controller,
                    decoration: const InputDecoration(labelText: '№5'),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  'Вступительные исп. сокращенное',
                  style: TextStyle(color: mainColor),
                ),
                children: [
                  TextFormField(
                    controller: _entranceShort1Controller,
                    decoration: const InputDecoration(labelText: '№1'),
                  ),
                  TextFormField(
                    controller: _entranceShort2Controller,
                    decoration: const InputDecoration(labelText: '№2'),
                  ),
                  TextFormField(
                    controller: _entranceShort3Controller,
                    decoration: const InputDecoration(labelText: '№3'),
                  ),
                  TextFormField(
                    controller: _entranceShort4Controller,
                    decoration: const InputDecoration(labelText: '№4'),
                  ),
                  TextFormField(
                    controller: _entranceShort5Controller,
                    decoration: const InputDecoration(labelText: '№5'),
                  ),
                ],
              ),


              // план приёма текущий год
              ExpansionTile(
                title: Text(
                  'План приёма 2021',
                  style: TextStyle(color: mainColor),
                ),
                children: [
                  TextFormField(
                    controller: _admissionCurrentDayFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное полное бюджет'),
                  ),
                  TextFormField(
                    controller: _admissionCurrentDayShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller: _admissionCurrentDayFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное полное платное'),
                  ),
                  TextFormField(
                    controller: _admissionCurrentDayShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное сокращённое платное'),
                  ),
                  TextFormField(
                    controller:
                    _admissionCurrentCorrespondenceFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _admissionCurrentCorrespondenceShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _admissionCurrentCorrespondenceFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное платное'),
                  ),
                  TextFormField(
                    controller:
                    _admissionCurrentCorrespondenceShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое платное'),
                  ),
                ],
              ),


              // проходные баллы прошлый год
              ExpansionTile(
                title: Text(
                  'Проходные баллы 2020',
                  style: TextStyle(color: mainColor),
                ),
                children: [
                  TextFormField(
                    controller: _passScorePrevYearDayFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Девное полное бюджет'),
                  ),
                  TextFormField(
                    controller: _passScorePrevYearDayShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Девное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller: _passScorePrevYearDayFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Девное полное платное'),
                  ),
                  TextFormField(
                    controller: _passScorePrevYearDayShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Девное сокращённое платное'),
                  ),
                  TextFormField(
                    controller:
                    _passScorePrevYearCorrespondenceFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _passScorePrevYearCorrespondenceShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _passScorePrevYearCorrespondenceFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное платное'),
                  ),
                  TextFormField(
                    controller:
                    _passScorePrevYearCorrespondenceShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое платное'),
                  ),
                ],
              ),

              //план приема прошлый год
              ExpansionTile(
                title: Text(
                  'План приёма 2020',
                  style: TextStyle(color: mainColor),
                ),
                children: [
                  TextFormField(
                    controller: _admissionPrevYearDayFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное полное бюджет'),
                  ),
                  TextFormField(
                    controller: _admissionPrevYearDayShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller: _admissionPrevYearDayFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное полное платное'),
                  ),
                  TextFormField(
                    controller: _admissionPrevYearDayShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное сокращённое платное'),
                  ),
                  TextFormField(
                    controller:
                    _admissionPrevYearCorrespondenceFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _admissionPrevYearCorrespondenceShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _admissionPrevYearCorrespondenceFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное платное'),
                  ),
                  TextFormField(
                    controller:
                    _admissionPrevYearCorrespondenceShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое платное'),
                  ),
                ],
              ),

              //проходные баллы позапрошлый год
              ExpansionTile(
                title: Text(
                  'Проходные баллы 2019',
                  style: TextStyle(color: mainColor),
                ),
                children: [
                  TextFormField(
                    controller:
                    _passScoreBeforeLastYearDayFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное полное бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _passScoreBeforeLastYearDayShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller: _passScoreBeforeLastYearDayFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное полное платное'),
                  ),
                  TextFormField(
                    controller:
                    _passScoreBeforeLastYearDayShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Дневное сокращённое платное'),
                  ),
                  TextFormField(
                    controller:
                    _passScoreBeforeLastYearCorrespondenceFullBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _passScoreBeforeLastYearCorrespondenceShortBudgetController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое бюджет'),
                  ),
                  TextFormField(
                    controller:
                    _passScoreBeforeLastYearCorrespondenceFullPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное полное платное'),
                  ),
                  TextFormField(
                    controller:
                    _passScoreBeforeLastYearCorrespondenceShortPaidController,
                    decoration: const InputDecoration(
                        labelText: 'Заочное сокращённое платное'),
                  ),
                ],
              ),

              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(labelText: 'Описание*'),
                validator: (value) {
                  if (value == '') return 'Введите описание';
                  return null;
                },
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.isEdit
                ? ElevatedButton(
                    onPressed: () {
                      _editSpeciality(widget.speciality!.id);
                    },
                    child: Text('Изменить'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(mainColor),
                      minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: mainColor),
                        ),
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      _addSpeciality();
                    },
                    child: Text('Добавить'),
                    style: ButtonStyle(
                      // foregroundColor: MaterialStateProperty.all(mainColor),
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: mainColor),
                        ),
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(mainColor),
                minimumSize: MaterialStateProperty.all(Size(120, 50)),
                elevation: MaterialStateProperty.all(10),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: mainColor),
                  ),
                ),
              ),
            ),
            if (widget.isEdit)
              ElevatedButton(
                onPressed: () {
                  _showAlertDialog(context, widget.speciality);
                },
                child: Icon(Icons.delete),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(50, 50)),
                  elevation: MaterialStateProperty.all(10),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: mainColor),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

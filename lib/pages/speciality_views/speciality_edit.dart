import 'package:bntu_app/models/speciality_model.dart';
import 'package:bntu_app/pages/speciality_views/speciality_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialityAdd extends StatefulWidget {
  const SpecialityAdd({Key? key, required this.speciality}) : super(key: key);
  final QueryDocumentSnapshot<Object?> speciality;

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
      //TODO: 'изменено' добавить
    }
  }

  void showAlertDialog(
      BuildContext context, QueryDocumentSnapshot<Object?> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 40,
            child: const Center(
                child: Text(
                  'Хотите удалить специальность?',
                  style: TextStyle(fontSize: 18),//TODO: дообавить проверку намерения путём написания аббревиатуры
                )),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _speciality.removeSpeciality(item.id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text('Удалить'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38),
              ),
              child: const Text('Отмена'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактирование специальности'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SpecialityForm(speciality: widget.speciality, isEdit: true),
        ),
      ),
    );
  }
}

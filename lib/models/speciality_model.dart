import 'package:cloud_firestore/cloud_firestore.dart';

class Speciality{
  String? facultyBased;
  String? name;
  String? number;
  String? about;
  String? qualification;
  String? trainingDurationDayFull; //дневное полное
  String? trainingDurationDayShort; //дневное сокращённое
  String? trainingDurationCorrespondenceFull; //заочное полное
  String? trainingDurationCorrespondenceShort; //заочное сокращённое
  List<String?>? entranceTestsFull; //вступительные экзамены на полное
  List<String?>? entranceShort; //вступительные экзамены на сокращённое
  // план приёма текущий год
  String? admissionCurrentDayFullBudget; //места дневное полное бюджет
  String? admissionCurrentDayShortBudget; //места дневное сокращённое бюджет
  String? admissionCurrentDayFullPaid; //места дневное полное платное
  String? admissionCurrentDayShortPaid; //места дневное сокращённое платное

  String? admissionCurrentCorrespondenceFullBudget; //места заочное полное бюджет
  String? admissionCurrentCorrespondenceShortBudget; //места заочное сокращённое бюджет
  String? admissionCurrentCorrespondenceFullPaid; //места заочное полное платное
  String? admissionCurrentCorrespondenceShortPaid; //места заочное сокращённое платное

  // проходные баллы прошлый год
  String? passScorePrevYearDayFullBudget; //баллы дневное полное бюджет
  String? passScorePrevYearDayShortBudget; //баллы дневное сокращённое бюджет
  String? passScorePrevYearDayFullPaid; //баллы дневное полное платное
  String? passScorePrevYearDayShortPaid; //баллы дневное сокращённое платное

  String? passScorePrevYearCorrespondenceFullBudget; //баллы заочное полное бюджет
  String? passScorePrevYearCorrespondenceShortBudget; //баллы заочное сокращённое бюджет
  String? passScorePrevYearCorrespondenceFullPaid; //баллы заочное полное платное
  String? passScorePrevYearCorrespondenceShortPaid; //баллы заочное сокращённое платное

  //план приема прошлый год
  String? admissionPrevYearDayFullBudget; //места дневное полное бюджет
  String? admissionPrevYearDayShortBudget; //места дневное сокращённое бюджет
  String? admissionPrevYearDayFullPaid; //места дневное полное платное
  String? admissionPrevYearDayShortPaid; //места дневное сокращённое платное

  String? admissionPrevYearCorrespondenceFullBudget; //места заочное полное бюджет
  String? admissionPrevYearCorrespondenceShortBudget; //места заочное сокращённое бюджет
  String? admissionPrevYearCorrespondenceFullPaid; //места заочное полное платное
  String? admissionPrevYearCorrespondenceShortPaid; //места заочное сокращённое платное

  //проходные баллы позапрошлый год
  String? passScoreBeforeLastYearDayFullBudget; //баллы дневное полное бюджет
  String? passScoreBeforeLastYearDayShortBudget; //баллы дневное сокращённое бюджет
  String? passScoreBeforeLastYearDayFullPaid; //баллы дневное полное платное
  String? passScoreBeforeLastYearDayShortPaid; //баллы дневное сокращённое платное

  String? passScoreBeforeLastYearCorrespondenceFullBudget; //баллы заочное полное бюджет
  String? passScoreBeforeLastYearCorrespondenceShortBudget; //баллы заочное сокращённое бюджет
  String? passScoreBeforeLastYearCorrespondenceFullPaid; //баллы заочное полное платное
  String? passScoreBeforeLastYearCorrespondenceShortPaid;  //баллы заочное сокращённое платное

  Speciality(
      {this.facultyBased,
      this.name,
      this.number,
      this.about,
      this.qualification,
      this.trainingDurationDayFull,
      this.trainingDurationDayShort,
      this.trainingDurationCorrespondenceFull,
      this.trainingDurationCorrespondenceShort,
      this.entranceTestsFull,
      this.entranceShort,
      this.admissionCurrentDayFullBudget,
      this.admissionCurrentDayShortBudget,
      this.admissionCurrentDayFullPaid,
      this.admissionCurrentDayShortPaid,
      this.admissionCurrentCorrespondenceFullBudget,
      this.admissionCurrentCorrespondenceShortBudget,
      this.admissionCurrentCorrespondenceFullPaid,
      this.admissionCurrentCorrespondenceShortPaid,
      this.passScorePrevYearDayFullBudget,
      this.passScorePrevYearDayShortBudget,
      this.passScorePrevYearDayFullPaid,
      this.passScorePrevYearDayShortPaid,
      this.passScorePrevYearCorrespondenceFullBudget,
      this.passScorePrevYearCorrespondenceShortBudget,
      this.passScorePrevYearCorrespondenceFullPaid,
      this.passScorePrevYearCorrespondenceShortPaid,
      this.admissionPrevYearDayFullBudget,
      this.admissionPrevYearDayShortBudget,
      this.admissionPrevYearDayFullPaid,
      this.admissionPrevYearDayShortPaid,
      this.admissionPrevYearCorrespondenceFullBudget,
      this.admissionPrevYearCorrespondenceShortBudget,
      this.admissionPrevYearCorrespondenceFullPaid,
      this.admissionPrevYearCorrespondenceShortPaid,
      this.passScoreBeforeLastYearDayFullBudget,
      this.passScoreBeforeLastYearDayShortBudget,
      this.passScoreBeforeLastYearDayFullPaid,
      this.passScoreBeforeLastYearDayShortPaid,
      this.passScoreBeforeLastYearCorrespondenceFullBudget,
      this.passScoreBeforeLastYearCorrespondenceShortBudget,
      this.passScoreBeforeLastYearCorrespondenceFullPaid,
      this.passScoreBeforeLastYearCorrespondenceShortPaid});

  final dbRef = FirebaseFirestore.instance;

  void addSpeciality(
      String facultyBased,
      String name,
      String number,
      String about,
      String qualification,
      String trainingDurationDayFull,
      String trainingDurationDayShort,
      String trainingDurationCorrespondenceFull,
      String trainingDurationCorrespondenceShort,
      List<String> entranceTestsFull,
      List<String> entranceShort,
      String admissionCurrentDayFullBudget,
      String admissionCurrentDayShortBudget,
      String admissionCurrentDayFullPaid,
      String admissionCurrentDayShortPaid,
      String admissionCurrentCorrespondenceFullBudget,
      String admissionCurrentCorrespondenceShortBudget,
      String admissionCurrentCorrespondenceFullPaid,
      String admissionCurrentCorrespondenceShortPaid,
      String passScorePrevYearDayFullBudget,
      String passScorePrevYearDayShortBudget,
      String passScorePrevYearDayFullPaid,
      String passScorePrevYearDayShortPaid,
      String passScorePrevYearCorrespondenceFullBudget,
      String passScorePrevYearCorrespondenceShortBudget,
      String passScorePrevYearCorrespondenceFullPaid,
      String passScorePrevYearCorrespondenceShortPaid,
      String admissionPrevYearDayFullBudget,
      String admissionPrevYearDayShortBudget,
      String admissionPrevYearDayFullPaid,
      String admissionPrevYearDayShortPaid,
      String admissionPrevYearCorrespondenceFullBudget,
      String admissionPrevYearCorrespondenceShortBudget,
      String admissionPrevYearCorrespondenceFullPaid,
      String admissionPrevYearCorrespondenceShortPaid,
      String passScoreBeforeLastYearDayFullBudget,
      String passScoreBeforeLastYearDayShortBudget,
      String passScoreBeforeLastYearDayFullPaid,
      String passScoreBeforeLastYearDayShortPaid,
      String passScoreBeforeLastYearCorrespondenceFullBudget,
      String passScoreBeforeLastYearCorrespondenceShortBudget,
      String passScoreBeforeLastYearCorrespondenceFullPaid,
      String passScoreBeforeLastYearCorrespondenceShortPaid,) async {
    await dbRef.collection('specialties').add({
      'facultyBased' : facultyBased,
      'name' : name,
      'number' : number,
      'about' : about,
      'qualification' : qualification,
      'trainingDurationDayFull' : trainingDurationDayFull,
      'trainingDurationDayShort' : trainingDurationDayShort,
      'trainingDurationCorrespondenceFull' : trainingDurationCorrespondenceFull,
      'trainingDurationCorrespondenceShort' : trainingDurationCorrespondenceShort,
      'entranceTestsFull' : entranceTestsFull,
      'entranceShort' : entranceShort,
      'admissionCurrentDayFullBudget' : admissionCurrentDayFullBudget,
      'admissionCurrentDayShortBudget' : admissionCurrentDayShortBudget,
      'admissionCurrentDayFullPaid' : admissionCurrentDayFullPaid,
      'admissionCurrentDayShortPaid' : admissionCurrentDayShortPaid,
      'admissionCurrentCorrespondenceFullBudget' : admissionCurrentCorrespondenceFullBudget,
      'admissionCurrentCorrespondenceShortBudget' : admissionCurrentCorrespondenceShortBudget,
      'admissionCurrentCorrespondenceFullPaid' : admissionCurrentCorrespondenceFullPaid,
      'admissionCurrentCorrespondenceShortPaid' : admissionCurrentCorrespondenceShortPaid,
      'passScorePrevYearDayFullBudget' : passScorePrevYearDayFullBudget,
      'passScorePrevYearDayShortBudget' : passScorePrevYearDayShortBudget,
      'passScorePrevYearDayFullPaid' : passScorePrevYearDayFullPaid,
      'passScorePrevYearDayShortPaid' : passScorePrevYearDayShortPaid,
      'passScorePrevYearCorrespondenceFullBudget' : passScorePrevYearCorrespondenceFullBudget,
      'passScorePrevYearCorrespondenceShortBudget' : passScorePrevYearCorrespondenceShortBudget,
      'passScorePrevYearCorrespondenceFullPaid' : passScorePrevYearCorrespondenceFullPaid,
      'passScorePrevYearCorrespondenceShortPaid' : passScorePrevYearCorrespondenceShortPaid,
      'admissionPrevYearDayFullBudget' : admissionPrevYearDayFullBudget,
      'admissionPrevYearDayShortBudget' : admissionPrevYearDayShortBudget,
      'admissionPrevYearDayFullPaid' : admissionPrevYearDayFullPaid,
      'admissionPrevYearDayShortPaid' : admissionPrevYearDayShortPaid,
      'admissionPrevYearCorrespondenceFullBudget' : admissionPrevYearCorrespondenceFullBudget,
      'admissionPrevYearCorrespondenceShortBudget' : admissionPrevYearCorrespondenceShortBudget,
      'admissionPrevYearCorrespondenceFullPaid' : admissionPrevYearCorrespondenceFullPaid,
      'admissionPrevYearCorrespondenceShortPaid' : admissionPrevYearCorrespondenceShortPaid,
      'passScoreBeforeLastYearDayFullBudget' : passScoreBeforeLastYearDayFullBudget,
      'passScoreBeforeLastYearDayShortBudget' : passScoreBeforeLastYearDayShortBudget,
      'passScoreBeforeLastYearDayFullPaid' : passScoreBeforeLastYearDayFullPaid,
      'passScoreBeforeLastYearDayShortPaid' : passScoreBeforeLastYearDayShortPaid,
      'passScoreBeforeLastYearCorrespondenceFullBudget' : passScoreBeforeLastYearCorrespondenceFullBudget,
      'passScoreBeforeLastYearCorrespondenceShortBudget' : passScoreBeforeLastYearCorrespondenceShortBudget,
      'passScoreBeforeLastYearCorrespondenceFullPaid' : passScoreBeforeLastYearCorrespondenceFullPaid,
      'passScoreBeforeLastYearCorrespondenceShortPaid' : passScoreBeforeLastYearCorrespondenceShortPaid,
    });
  }

  void editSpeciality(
      String facultyBased,
      String name,
      String number,
      String about,
      String qualification,
      String trainingDurationDayFull,
      String trainingDurationDayShort,
      String trainingDurationCorrespondenceFull,
      String trainingDurationCorrespondenceShort,
      List<String> entranceTestsFull,
      List<String> entranceShort,
      String admissionCurrentDayFullBudget,
      String admissionCurrentDayShortBudget,
      String admissionCurrentDayFullPaid,
      String admissionCurrentDayShortPaid,
      String admissionCurrentCorrespondenceFullBudget,
      String admissionCurrentCorrespondenceShortBudget,
      String admissionCurrentCorrespondenceFullPaid,
      String admissionCurrentCorrespondenceShortPaid,
      String passScorePrevYearDayFullBudget,
      String passScorePrevYearDayShortBudget,
      String passScorePrevYearDayFullPaid,
      String passScorePrevYearDayShortPaid,
      String passScorePrevYearCorrespondenceFullBudget,
      String passScorePrevYearCorrespondenceShortBudget,
      String passScorePrevYearCorrespondenceFullPaid,
      String passScorePrevYearCorrespondenceShortPaid,
      String admissionPrevYearDayFullBudget,
      String admissionPrevYearDayShortBudget,
      String admissionPrevYearDayFullPaid,
      String admissionPrevYearDayShortPaid,
      String admissionPrevYearCorrespondenceFullBudget,
      String admissionPrevYearCorrespondenceShortBudget,
      String admissionPrevYearCorrespondenceFullPaid,
      String admissionPrevYearCorrespondenceShortPaid,
      String passScoreBeforeLastYearDayFullBudget,
      String passScoreBeforeLastYearDayShortBudget,
      String passScoreBeforeLastYearDayFullPaid,
      String passScoreBeforeLastYearDayShortPaid,
      String passScoreBeforeLastYearCorrespondenceFullBudget,
      String passScoreBeforeLastYearCorrespondenceShortBudget,
      String passScoreBeforeLastYearCorrespondenceFullPaid,
      String passScoreBeforeLastYearCorrespondenceShortPaid,
      String id) async {
    await dbRef.collection('specialties').doc(id).update({
      'facultyBased' : facultyBased,
      'name' : name,
      'number' : number,
      'about' : about,
      'qualification' : qualification,
      'trainingDurationDayFull' : trainingDurationDayFull,
      'trainingDurationDayShort' : trainingDurationDayShort,
      'trainingDurationCorrespondenceFull' : trainingDurationCorrespondenceFull,
      'trainingDurationCorrespondenceShort' : trainingDurationCorrespondenceShort,
      'entranceTestsFull' : entranceTestsFull,
      'entranceShort' : entranceShort,
      'admissionCurrentDayFullBudget' : admissionCurrentDayFullBudget,
      'admissionCurrentDayShortBudget' : admissionCurrentDayShortBudget,
      'admissionCurrentDayFullPaid' : admissionCurrentDayFullPaid,
      'admissionCurrentDayShortPaid' : admissionCurrentDayShortPaid,
      'admissionCurrentCorrespondenceFullBudget' : admissionCurrentCorrespondenceFullBudget,
      'admissionCurrentCorrespondenceShortBudget' : admissionCurrentCorrespondenceShortBudget,
      'admissionCurrentCorrespondenceFullPaid' : admissionCurrentCorrespondenceFullPaid,
      'admissionCurrentCorrespondenceShortPaid' : admissionCurrentCorrespondenceShortPaid,
      'passScorePrevYearDayFullBudget' : passScorePrevYearDayFullBudget,
      'passScorePrevYearDayShortBudget' : passScorePrevYearDayShortBudget,
      'passScorePrevYearDayFullPaid' : passScorePrevYearDayFullPaid,
      'passScorePrevYearDayShortPaid' : passScorePrevYearDayShortPaid,
      'passScorePrevYearCorrespondenceFullBudget' : passScorePrevYearCorrespondenceFullBudget,
      'passScorePrevYearCorrespondenceShortBudget' : passScorePrevYearCorrespondenceShortBudget,
      'passScorePrevYearCorrespondenceFullPaid' : passScorePrevYearCorrespondenceFullPaid,
      'passScorePrevYearCorrespondenceShortPaid' : passScorePrevYearCorrespondenceShortPaid,
      'admissionPrevYearDayFullBudget' : admissionPrevYearDayFullBudget,
      'admissionPrevYearDayShortBudget' : admissionPrevYearDayShortBudget,
      'admissionPrevYearDayFullPaid' : admissionPrevYearDayFullPaid,
      'admissionPrevYearDayShortPaid' : admissionPrevYearDayShortPaid,
      'admissionPrevYearCorrespondenceFullBudget' : admissionPrevYearCorrespondenceFullBudget,
      'admissionPrevYearCorrespondenceShortBudget' : admissionPrevYearCorrespondenceShortBudget,
      'admissionPrevYearCorrespondenceFullPaid' : admissionPrevYearCorrespondenceFullPaid,
      'admissionPrevYearCorrespondenceShortPaid' : admissionPrevYearCorrespondenceShortPaid,
      'passScoreBeforeLastYearDayFullBudget' : passScoreBeforeLastYearDayFullBudget,
      'passScoreBeforeLastYearDayShortBudget' : passScoreBeforeLastYearDayShortBudget,
      'passScoreBeforeLastYearDayFullPaid' : passScoreBeforeLastYearDayFullPaid,
      'passScoreBeforeLastYearDayShortPaid' : passScoreBeforeLastYearDayShortPaid,
      'passScoreBeforeLastYearCorrespondenceFullBudget' : passScoreBeforeLastYearCorrespondenceFullBudget,
      'passScoreBeforeLastYearCorrespondenceShortBudget' : passScoreBeforeLastYearCorrespondenceShortBudget,
      'passScoreBeforeLastYearCorrespondenceFullPaid' : passScoreBeforeLastYearCorrespondenceFullPaid,
      'passScoreBeforeLastYearCorrespondenceShortPaid' : passScoreBeforeLastYearCorrespondenceShortPaid,
    });
  }

  void removeSpeciality(String id) async {
    await dbRef.collection('specialties').doc(id).delete();
  }

  List<Map<String, String>> admissionsCurrentYearList = [
    {'admission' : 'admissionCurrentDayFullBudget', 'description' : 'Бюджет дневное'},
    {'admission' : 'admissionCurrentDayShortBudget', 'description' : 'Бюджет дневное (сокращенное)'},
    {'admission' : 'admissionCurrentDayFullPaid', 'description' : 'Платное дневное'},
    {'admission' : 'admissionCurrentDayShortPaid', 'description' : 'Платное дневное (сокращенное)'},
    {'admission' : 'admissionCurrentCorrespondenceFullBudget', 'description' : 'Бюджет заочное'},
    {'admission' : 'admissionCurrentCorrespondenceShortBudget', 'description' : 'Бюджет заочное (сокращенное)'},
    {'admission' : 'admissionCurrentCorrespondenceFullPaid', 'description' : 'Платное заочное'},
    {'admission' : 'admissionCurrentCorrespondenceShortPaid', 'description' : 'Платное заочное (сокращенное)'},
  ];

  List<Map<String, String>> passScorePrevYearList = [
    {'passScore' : 'passScorePrevYearDayFullBudget', 'description' : 'Бюджет дневное'},
    {'passScore' : 'passScorePrevYearDayShortBudget', 'description' : 'Бюджет дневное (сокращенное)'},
    {'passScore' : 'passScorePrevYearDayFullPaid', 'description' : 'Платное дневное'},
    {'passScore' : 'passScorePrevYearDayShortPaid', 'description' : 'Платное дневное (сокращенное)'},
    {'passScore' : 'passScorePrevYearCorrespondenceFullBudget', 'description' : 'Бюджет заочное'},
    {'passScore' : 'passScorePrevYearCorrespondenceShortBudget', 'description' : 'Бюджет заочное (сокращенное)'},
    {'passScore' : 'passScorePrevYearCorrespondenceFullPaid', 'description' : 'Платное заочное'},
    {'passScore' : 'passScorePrevYearCorrespondenceShortPaid', 'description' : 'Платное заочное (сокращенное)'},
  ];

  List<Map<String, String>> admissionsPrevYearList = [
    {'admission' : 'admissionPrevYearDayFullBudget', 'description' : 'Бюджет дневное'},
    {'admission' : 'admissionPrevYearDayShortBudget', 'description' : 'Бюджет дневное (сокращенное)'},
    {'admission' : 'admissionPrevYearDayFullPaid', 'description' : 'Платное дневное'},
    {'admission' : 'admissionPrevYearDayShortPaid', 'description' : 'Платное дневное (сокращенное)'},
    {'admission' : 'admissionPrevYearCorrespondenceFullBudget', 'description' : 'Бюджет заочное'},
    {'admission' : 'admissionPrevYearCorrespondenceShortBudget', 'description' : 'Бюджет заочное (сокращенное)'},
    {'admission' : 'admissionPrevYearCorrespondenceFullPaid', 'description' : 'Платное заочное'},
    {'admission' : 'admissionPrevYearCorrespondenceShortPaid', 'description' : 'Платное заочное (сокращенное)'},
  ];

  List<Map<String, String>> passScoreBeforeLastYearList = [
    {'passScore' : 'passScoreBeforeLastYearDayFullBudget', 'description' : 'Бюджет дневное'},
    {'passScore' : 'passScoreBeforeLastYearDayShortBudget', 'description' : 'Бюджет дневное (сокращенное)'},
    {'passScore' : 'passScoreBeforeLastYearDayFullPaid', 'description' : 'Платное дневное'},
    {'passScore' : 'passScoreBeforeLastYearDayShortPaid', 'description' : 'Платное дневное (сокращенное)'},
    {'passScore' : 'passScoreBeforeLastYearCorrespondenceFullBudget', 'description' : 'Бюджет заочное'},
    {'passScore' : 'passScoreBeforeLastYearCorrespondenceShortBudget', 'description' : 'Бюджет заочное (сокращенное)'},
    {'passScore' : 'passScoreBeforeLastYearCorrespondenceFullPaid', 'description' : 'Платное заочное'},
    {'passScore' : 'passScoreBeforeLastYearCorrespondenceShortPaid', 'description' : 'Платное заочное (сокращенное)'},
  ];

}
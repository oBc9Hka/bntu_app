import 'dart:async';

import 'package:bntu_app/models/speciality_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialtiesFirestoreRepository extends SpecialtiesRepository {
  final dbRef = FirebaseFirestore.instance.collection('specialties');

  @override
  Future<List<Speciality>> getSpecialtiesList() async {
    List<Speciality> list = [];
    QuerySnapshot<Map<String, dynamic>> temp = await dbRef.get();

    if (temp.docs.isEmpty) {
      throw TimeoutException('Ошибка соединения');
    }

    for (var speciality in temp.docs) {
      list.add(Speciality.fromMap(speciality.data(), speciality.id));
    }

    list.sort((a, b) => a.name!.compareTo(b.name!));

    return list;
  }

  @override
  Future<void> addSpeciality(
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
  ) async {
    await dbRef.add({
      'facultyBased': facultyBased,
      'name': name,
      'number': number,
      'about': about,
      'qualification': qualification,
      'trainingDurationDayFull': trainingDurationDayFull,
      'trainingDurationDayShort': trainingDurationDayShort,
      'trainingDurationCorrespondenceFull': trainingDurationCorrespondenceFull,
      'trainingDurationCorrespondenceShort':
          trainingDurationCorrespondenceShort,
      'entranceTestsFull': entranceTestsFull,
      'entranceShort': entranceShort,
      'admissionCurrentDayFullBudget': admissionCurrentDayFullBudget,
      'admissionCurrentDayShortBudget': admissionCurrentDayShortBudget,
      'admissionCurrentDayFullPaid': admissionCurrentDayFullPaid,
      'admissionCurrentDayShortPaid': admissionCurrentDayShortPaid,
      'admissionCurrentCorrespondenceFullBudget':
          admissionCurrentCorrespondenceFullBudget,
      'admissionCurrentCorrespondenceShortBudget':
          admissionCurrentCorrespondenceShortBudget,
      'admissionCurrentCorrespondenceFullPaid':
          admissionCurrentCorrespondenceFullPaid,
      'admissionCurrentCorrespondenceShortPaid':
          admissionCurrentCorrespondenceShortPaid,
      'passScorePrevYearDayFullBudget': passScorePrevYearDayFullBudget,
      'passScorePrevYearDayShortBudget': passScorePrevYearDayShortBudget,
      'passScorePrevYearDayFullPaid': passScorePrevYearDayFullPaid,
      'passScorePrevYearDayShortPaid': passScorePrevYearDayShortPaid,
      'passScorePrevYearCorrespondenceFullBudget':
          passScorePrevYearCorrespondenceFullBudget,
      'passScorePrevYearCorrespondenceShortBudget':
          passScorePrevYearCorrespondenceShortBudget,
      'passScorePrevYearCorrespondenceFullPaid':
          passScorePrevYearCorrespondenceFullPaid,
      'passScorePrevYearCorrespondenceShortPaid':
          passScorePrevYearCorrespondenceShortPaid,
      'admissionPrevYearDayFullBudget': admissionPrevYearDayFullBudget,
      'admissionPrevYearDayShortBudget': admissionPrevYearDayShortBudget,
      'admissionPrevYearDayFullPaid': admissionPrevYearDayFullPaid,
      'admissionPrevYearDayShortPaid': admissionPrevYearDayShortPaid,
      'admissionPrevYearCorrespondenceFullBudget':
          admissionPrevYearCorrespondenceFullBudget,
      'admissionPrevYearCorrespondenceShortBudget':
          admissionPrevYearCorrespondenceShortBudget,
      'admissionPrevYearCorrespondenceFullPaid':
          admissionPrevYearCorrespondenceFullPaid,
      'admissionPrevYearCorrespondenceShortPaid':
          admissionPrevYearCorrespondenceShortPaid,
      'passScoreBeforeLastYearDayFullBudget':
          passScoreBeforeLastYearDayFullBudget,
      'passScoreBeforeLastYearDayShortBudget':
          passScoreBeforeLastYearDayShortBudget,
      'passScoreBeforeLastYearDayFullPaid': passScoreBeforeLastYearDayFullPaid,
      'passScoreBeforeLastYearDayShortPaid':
          passScoreBeforeLastYearDayShortPaid,
      'passScoreBeforeLastYearCorrespondenceFullBudget':
          passScoreBeforeLastYearCorrespondenceFullBudget,
      'passScoreBeforeLastYearCorrespondenceShortBudget':
          passScoreBeforeLastYearCorrespondenceShortBudget,
      'passScoreBeforeLastYearCorrespondenceFullPaid':
          passScoreBeforeLastYearCorrespondenceFullPaid,
      'passScoreBeforeLastYearCorrespondenceShortPaid':
          passScoreBeforeLastYearCorrespondenceShortPaid,
    });
  }

  @override
  Future<void> editSpeciality(
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
    await dbRef.doc(id).update({
      'facultyBased': facultyBased,
      'name': name,
      'number': number,
      'about': about,
      'qualification': qualification,
      'trainingDurationDayFull': trainingDurationDayFull,
      'trainingDurationDayShort': trainingDurationDayShort,
      'trainingDurationCorrespondenceFull': trainingDurationCorrespondenceFull,
      'trainingDurationCorrespondenceShort':
          trainingDurationCorrespondenceShort,
      'entranceTestsFull': entranceTestsFull,
      'entranceShort': entranceShort,
      'admissionCurrentDayFullBudget': admissionCurrentDayFullBudget,
      'admissionCurrentDayShortBudget': admissionCurrentDayShortBudget,
      'admissionCurrentDayFullPaid': admissionCurrentDayFullPaid,
      'admissionCurrentDayShortPaid': admissionCurrentDayShortPaid,
      'admissionCurrentCorrespondenceFullBudget':
          admissionCurrentCorrespondenceFullBudget,
      'admissionCurrentCorrespondenceShortBudget':
          admissionCurrentCorrespondenceShortBudget,
      'admissionCurrentCorrespondenceFullPaid':
          admissionCurrentCorrespondenceFullPaid,
      'admissionCurrentCorrespondenceShortPaid':
          admissionCurrentCorrespondenceShortPaid,
      'passScorePrevYearDayFullBudget': passScorePrevYearDayFullBudget,
      'passScorePrevYearDayShortBudget': passScorePrevYearDayShortBudget,
      'passScorePrevYearDayFullPaid': passScorePrevYearDayFullPaid,
      'passScorePrevYearDayShortPaid': passScorePrevYearDayShortPaid,
      'passScorePrevYearCorrespondenceFullBudget':
          passScorePrevYearCorrespondenceFullBudget,
      'passScorePrevYearCorrespondenceShortBudget':
          passScorePrevYearCorrespondenceShortBudget,
      'passScorePrevYearCorrespondenceFullPaid':
          passScorePrevYearCorrespondenceFullPaid,
      'passScorePrevYearCorrespondenceShortPaid':
          passScorePrevYearCorrespondenceShortPaid,
      'admissionPrevYearDayFullBudget': admissionPrevYearDayFullBudget,
      'admissionPrevYearDayShortBudget': admissionPrevYearDayShortBudget,
      'admissionPrevYearDayFullPaid': admissionPrevYearDayFullPaid,
      'admissionPrevYearDayShortPaid': admissionPrevYearDayShortPaid,
      'admissionPrevYearCorrespondenceFullBudget':
          admissionPrevYearCorrespondenceFullBudget,
      'admissionPrevYearCorrespondenceShortBudget':
          admissionPrevYearCorrespondenceShortBudget,
      'admissionPrevYearCorrespondenceFullPaid':
          admissionPrevYearCorrespondenceFullPaid,
      'admissionPrevYearCorrespondenceShortPaid':
          admissionPrevYearCorrespondenceShortPaid,
      'passScoreBeforeLastYearDayFullBudget':
          passScoreBeforeLastYearDayFullBudget,
      'passScoreBeforeLastYearDayShortBudget':
          passScoreBeforeLastYearDayShortBudget,
      'passScoreBeforeLastYearDayFullPaid': passScoreBeforeLastYearDayFullPaid,
      'passScoreBeforeLastYearDayShortPaid':
          passScoreBeforeLastYearDayShortPaid,
      'passScoreBeforeLastYearCorrespondenceFullBudget':
          passScoreBeforeLastYearCorrespondenceFullBudget,
      'passScoreBeforeLastYearCorrespondenceShortBudget':
          passScoreBeforeLastYearCorrespondenceShortBudget,
      'passScoreBeforeLastYearCorrespondenceFullPaid':
          passScoreBeforeLastYearCorrespondenceFullPaid,
      'passScoreBeforeLastYearCorrespondenceShortPaid':
          passScoreBeforeLastYearCorrespondenceShortPaid,
    });
  }

  @override
  Future<void> removeSpeciality(String id) async {
    await dbRef.doc(id).delete();
  }
}

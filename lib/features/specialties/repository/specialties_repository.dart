import 'dart:async';

import 'package:bntu_app/features/specialties/domain/models/speciality_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/repository/specialties_repository.dart';

class SpecialtiesFirestoreRepository extends SpecialtiesRepository {
  final dbRef = FirebaseFirestore.instance.collection('specialtiesV2');

  @override
  Future<List<Speciality>> getSpecialtiesList() async {
    final list = <Speciality>[];
    final temp = await dbRef.get();

    if (temp.docs.isEmpty) {
      throw TimeoutException('Ошибка соединения');
    }

    for (var speciality in temp.docs) {
      final data = speciality.data();
      data.addAll({'id': speciality.id});
      list.add(Speciality.fromJson(data));
    }

    list.sort((a, b) => a.name!.compareTo(b.name!));

    return list;
  }

  @override
  Future<void> addSpeciality(
    Speciality speciality,
  ) async {
    final json = speciality.toJson();
    await dbRef.add(json);
  }

  @override
  Future<void> editSpeciality(
    Speciality speciality,
    String id,
  ) async {
    await dbRef.doc(id).update(speciality.toJson());
  }

  @override
  Future<void> removeSpeciality(String id) async {
    await dbRef.doc(id).delete();
  }
}

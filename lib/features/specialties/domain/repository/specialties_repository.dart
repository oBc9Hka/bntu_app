import '../models/speciality_model.dart';

abstract class SpecialtiesRepository {
  const SpecialtiesRepository();

  Future<List<Speciality>> getSpecialtiesList();

  Future<void> addSpeciality(Speciality speciality);

  Future<void> editSpeciality(Speciality speciality, String id);

  Future<void> removeSpeciality(String id);
}

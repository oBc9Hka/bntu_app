import 'package:flutter/foundation.dart';

import '../domain/models/speciality_model.dart';
import '../domain/repository/specialties_repository.dart';

class SpecialtiesProvider with ChangeNotifier {
  final SpecialtiesRepository specialtiesRepository;

  List<Speciality> specialties = [];

  Speciality specialityInEdit = Speciality();

  String currentAdmissionYear = '2021';

  bool isLoading = false;

  SpecialtiesProvider({required this.specialtiesRepository}) {
    getSpecialties();
  }

  void getSpecialties({List<String>? qualificationNeedToShow}) async {
    isLoading = true;
    notifyListeners();
    final specialtiesResult = await specialtiesRepository.getSpecialtiesList();
    specialties = [];
    if (qualificationNeedToShow != null) {
      for (var item in specialtiesResult) {
        if (qualificationNeedToShow.contains(item.qualification)) {
          specialties.add(item);
        }
      }
    } else {
      specialties = specialtiesResult;
    }
    isLoading = false;
    notifyListeners();
  }

  void setSpecialityInEdit(Speciality speciality) {
    specialityInEdit = speciality;
    notifyListeners();
  }

  void addSpeciality() {
    specialtiesRepository.addSpeciality(specialityInEdit);
    notifyListeners();
  }

  void editSpeciality(
    Speciality speciality,
  ) {
    specialtiesRepository.editSpeciality(
      speciality,
      speciality.id!,
    );
    notifyListeners();
  }

  void removeSpeciality(String id) {
    specialtiesRepository.removeSpeciality(id);
    notifyListeners();
  }

  void notif() {
    notifyListeners();
  }
}

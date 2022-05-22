import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/speciality_model.dart';
import '../domain/repository/specialties_repository.dart';

class SpecialtiesProvider with ChangeNotifier {
  final SpecialtiesRepository specialtiesRepository;

  List<Speciality> specialties = [];

  Speciality specialityInEdit = Speciality();

  String lastShowingYear = '0';

  bool isLoading = false;

  SpecialtiesProvider({
    required this.specialtiesRepository,
  });

  void getSpecialties({List<String>? qualificationNeedToShow}) async {
    isLoading = true;
    notifyListeners();
    final instance = await SharedPreferences.getInstance();
    lastShowingYear = instance.getString('lastShowingYear') ?? '0';
    specialties = [];
    final specialtiesResult = await specialtiesRepository.getSpecialtiesList();

    // filter for last showing year
    final tempList = [];

    for (var i = 0; i < specialtiesResult.length; i++) {
      tempList.clear();
      specialtiesResult[i].admissions.forEach((element) {
        if (int.parse(element.year) > int.parse(lastShowingYear)) {
          tempList.add(element);
        }
      });
      for (final item in tempList) {
        specialtiesResult[i].admissions.remove(item);
      }
    }

    // filter for showing by qualifications
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

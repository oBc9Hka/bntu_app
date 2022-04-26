import 'package:flutter/foundation.dart';

import '../domain/models/faculty_model.dart';
import '../domain/repository/faculties_repository.dart';

class FacultiesProvider with ChangeNotifier {
  final FacultiesRepository facultiesRepository;

  List<Faculty> faculties = [];
  List<String> facultiesShortNames = [];

  bool get isFacultiesLoaded => faculties.isNotEmpty;
  bool isList = true; // ListView or GridView at faculties page

  FacultiesProvider({required this.facultiesRepository}) {
    initFaculties();
  }

  void initFaculties() async {
    faculties = await facultiesRepository.getFacultiesList();
    facultiesShortNames = await facultiesRepository.getFacultiesShortNames();
    notifyListeners();
  }

  void addFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
  ) {
    try {
      facultiesRepository.addFaculty(
        name,
        shortName,
        about,
        hotLineNumber,
        hotLineMail,
        forInquiriesNumber,
        forHostelNumber,
        imagePath,
      );
    } catch (e) {
      throw 'Непредвиденная ошибка: $e';
    }
    notifyListeners();
  }

  void editFaculty(
      String name,
      String shortName,
      String about,
      String hotLineNumber,
      String hotLineMail,
      String forInquiriesNumber,
      String forHostelNumber,
      String imagePath,
      String id) {
    facultiesRepository.editFaculty(
      name,
      shortName,
      about,
      hotLineNumber,
      hotLineMail,
      forInquiriesNumber,
      forHostelNumber,
      imagePath,
      id,
    );
    notifyListeners();
  }

  void removeFaculty(String id, String packageName) {
    facultiesRepository.removeFaculty(id, packageName);
    notifyListeners();
  }
}

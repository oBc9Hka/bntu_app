import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  late final FacultiesRepository _facultiesRepository;
  List<Faculty> faculties = [];
  bool get isFacultiesLoaded => faculties.isNotEmpty;

  AppProvider(this._facultiesRepository){
    _initFaculties();
  }

  void _initFaculties() async {
    faculties = await _facultiesRepository.getFacultiesList();
    notifyListeners();
  }
}

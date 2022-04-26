import '../models/faculty_model.dart';

abstract class FacultiesRepository {
  const FacultiesRepository();

  Future<List<Faculty>> getFacultiesList();

  Future<List<String>> getFacultiesShortNames();

  Future<Faculty> getFacultyByShortName(String name);

  Future<void> addFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
  );

  Future<void> editFaculty(
    String name,
    String shortName,
    String about,
    String hotLineNumber,
    String hotLineMail,
    String forInquiriesNumber,
    String forHostelNumber,
    String imagePath,
    String id,
  );

  Future<void> removeFaculty(String id, String name);
}

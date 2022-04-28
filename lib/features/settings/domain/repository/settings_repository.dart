abstract class SettingsRepository {
  Future<String> getCurrentAdmissionYear();

  Future<String> getSecretKey();

  Future<String> getNameOfCheckedTest();

  Future<bool> getIsFacultyQuizChecked();

  Future<void> editQuizChecked(bool isFacultiesQuiz);

  Future<void> editCheckedQuiz(String nameOfQuizChecked);

  Future<void> editSettings(String currentAdmissionYear, String key);
}

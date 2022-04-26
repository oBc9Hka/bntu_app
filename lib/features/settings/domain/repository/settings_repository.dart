abstract class SettingsRepository {
  Future<String> getCurrentAdmissionYear();

  Future<String> getSecretKey();

  Future<bool> getIsFacultyQuizChecked();

  Future<void> editQuizChecked(bool isFacultiesQuiz);

  Future<void> editSettings(String currentAdmissionYear, String key);
}

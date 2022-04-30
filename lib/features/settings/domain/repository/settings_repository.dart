abstract class SettingsRepository {
  Future<String> getCurrentAdmissionYear();

  Future<String> getSecretKey();

  Future<String> getCheckedQuizId();

  Future<bool> getIsFacultyQuizChecked();

  Future<void> editQuizChecked(bool isFacultiesQuiz);

  Future<void> editCheckedQuiz(String checkedQuizId);

  Future<void> editSettings(String currentAdmissionYear, String key);
}

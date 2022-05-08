abstract class SettingsRepository {
  Future<String> getCurrentAdmissionYear();

  Future<String> getSecretKey();

  Future<List<String>> getCheckedQuizIds();

  Future<void> editCheckedQuizIds({required List<String> checkedQuizIds});

  Future<void> editSettings(String currentAdmissionYear, String key);
}

import 'package:flutter/foundation.dart';

import '../../../core/domain/models/error_message_model.dart';
import '../../../core/domain/repository/error_messages_repository.dart';
import '../domain/repository/settings_repository.dart';

class SettingsProvider with ChangeNotifier {
  final SettingsRepository settingsRepository;
  final ErrorMessagesRepository errorMessagesRepository;

  SettingsProvider({
    required this.settingsRepository,
    required this.errorMessagesRepository,
  }) {
    initSettings();
  }

  String currentAdmissionYear = '';
  String secretKey = '';
  String unseenCount = '0';
  bool isFacultiesQuiz = true; // Quiz for faculties or specialties
  List<ErrorMessage> errorMessages = [];

  void initSettings() async {
    currentAdmissionYear = await settingsRepository.getCurrentAdmissionYear();
    secretKey = await settingsRepository.getSecretKey();
    isFacultiesQuiz = await settingsRepository.getIsFacultyQuizChecked();
    initErrorMessages();
    notifyListeners();
  }

  void initErrorMessages() async {
    errorMessages = await errorMessagesRepository.getErrorMessagesList();
    unseenCount = await errorMessagesRepository.getUnseenMessages();
    notifyListeners();
  }

  void editSettings(String currentAdmissionYear, String key) {
    settingsRepository
        .editSettings(currentAdmissionYear, key)
        .whenComplete(() => initSettings());
    notifyListeners();
  }

  void editQuizChecked(bool isFacultiesQuiz) {
    settingsRepository
        .editQuizChecked(isFacultiesQuiz)
        .whenComplete(() => initSettings());
    notifyListeners();
  }

  void changeViewedState(String id) async {
    await errorMessagesRepository.changeViewedState(id).whenComplete(() {
      initSettings();
      initErrorMessages();
    });
    notifyListeners();
  }

  void removeErrorMessage(String id) async {
    await errorMessagesRepository.removeErrorMessage(id).whenComplete(() {
      initSettings();
      initErrorMessages();
    });
    notifyListeners();
  }
}

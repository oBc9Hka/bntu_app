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

  List<String> quizIds = [];
  String currentAdmissionYear = '';
  String secretKey = '';
  String unseenCount = '0';
  List<ErrorMessage> errorMessages = [];

  Future<void> initSettings() async {
    currentAdmissionYear = await settingsRepository.getCurrentAdmissionYear();
    secretKey = await settingsRepository.getSecretKey();
    await initErrorMessages();
    await getCheckedTestsIds();
    notifyListeners();
  }

  Future<void> initErrorMessages() async {
    errorMessages = await errorMessagesRepository.getErrorMessagesList();
    unseenCount = await errorMessagesRepository.getUnseenMessages();
    notifyListeners();
  }

  Future<void> getCheckedTestsIds() async {
    quizIds = await settingsRepository.getCheckedQuizIds();
    notifyListeners();
  }

  Future<void> editCheckedQuizIds({required List<String> newList}) async {
    quizIds = newList;
    notifyListeners();
  }

  Future<void> saveCheckedQuizIds() async {
    await settingsRepository.editCheckedQuizIds(checkedQuizIds: quizIds);
    notifyListeners();
  }

  void editSettings(String currentAdmissionYear, String key) {
    settingsRepository
        .editSettings(currentAdmissionYear, key)
        .whenComplete(() => initSettings());
    notifyListeners();
  }

  void changeCheckedTest(List<String> quizIds) async {
    await settingsRepository
        .editCheckedQuizIds(checkedQuizIds: quizIds)
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

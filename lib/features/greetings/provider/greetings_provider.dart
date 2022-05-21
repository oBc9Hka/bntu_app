import 'package:flutter/foundation.dart';

import '../../../core/domain/repository/error_messages_repository.dart';

class GreetingsProvider with ChangeNotifier {
  final ErrorMessagesRepository errorMessagesRepository;

  GreetingsProvider({
    required this.errorMessagesRepository,
  });

  void submitErrorMessage(String msg) {
    errorMessagesRepository.submitErrorMessage(msg);
    notifyListeners();
  }
}

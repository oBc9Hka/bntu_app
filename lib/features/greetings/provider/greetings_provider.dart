import 'package:flutter/foundation.dart';

import '../domain/repository/error_messages_repository.dart';

class GreetingsProvider with ChangeNotifier {
  final ErrorMessagesRepository errorMessagesRepository;

  String secretKey = '';

  GreetingsProvider({
    required this.errorMessagesRepository,
  });

  void submitErrorMessage(String msg) {
    errorMessagesRepository.submitErrorMessage(msg);
    notifyListeners();
  }

  // void initErrorMessages() async {
  //   errorMessages = await errorMessagesRepository.getErrorMessagesList();
  //   unseenCount = await errorMessagesRepository.getUnseenMessages();
  //   notifyListeners();
  // }
}

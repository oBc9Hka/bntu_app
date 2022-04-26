import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../domain/repository/error_messages_repository.dart';
import '../domain/repository/user_repository.dart';

class GreetingsProvider with ChangeNotifier {
  final UserRepository userRepository;
  final ErrorMessagesRepository errorMessagesRepository;

  User? user;
  Map<String, dynamic> errorsMap = {};
  String secretKey = '';

  GreetingsProvider({
    required this.userRepository,
    required this.errorMessagesRepository,
  }) {
    initUser();
  }

  void initUser() async {
    user = await userRepository
        .getCurrentUser()
        .whenComplete(() => initErrorsMap());

    notifyListeners();
  }

  void initErrorsMap() {
    errorsMap = userRepository.getErrors();
    notifyListeners();
  }

  void signUp(String email, String password) {
    userRepository.signUp(email, password).whenComplete(() => initUser());
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await userRepository.signIn(email, password).whenComplete(() {
      initUser();
      initErrorsMap();
    });
    notifyListeners();
  }

  void signOut() {
    userRepository.signOut().whenComplete(() => initUser());
    notifyListeners();
  }

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

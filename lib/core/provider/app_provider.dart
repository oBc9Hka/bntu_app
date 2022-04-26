import 'package:bntu_app/core/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  final UserRepository userRepository;

  User? user;
  Map<String, dynamic> errorsMap = {};

  AppProvider({required this.userRepository}) {
    initUser();
    initErrorsMap();
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
}

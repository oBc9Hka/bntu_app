import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  late String errorMessage;
  late String errorEmailMessage;
  late String errorPasswordMessage;
  bool hasError = false;
  bool hasEmailError = false;
  bool hasPasswordError = false;
  bool tooManyRequestsError = false;

  Map<String, dynamic> getErrors();

  Future<void> signUp(String email, String password);

  Future<void> signIn(String email, String password);

  Future<void> signOut();

  Future<User?> getCurrentUser();

  // Future<void> getUsersList();
}

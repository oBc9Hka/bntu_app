import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  bool isAdmin = true;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var _firebaseAuthListen = FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  late String errorMessage;
  late String errorEmailMessage;
  late String errorPasswordMessage;
  bool hasError = false;
  bool hasEmailError = false;
  bool hasPasswordError = false;
  bool tooManyRequestsError = false;
  CollectionReference dbRef = FirebaseFirestore.instance.collection('User');

  //TODO: create MainAdmin and add ability to create new accounts to MainAdmin and fix it at firebase rules
  // Future signUp(String email, String password) async {
  //   try {
  //     clearErrors();
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return _firebaseAuth.currentUser;
  //   } on FirebaseAuthException catch (e) {
  //     print('Failed with error code: ${e.code}');
  //     hasError = true;
  //     if (e.code == 'email-already-in-use') {
  //       hasEmailError = true;
  //       errorEmailMessage = 'Данная почта уже занята';
  //     } else if (e.code == 'weak-password') {
  //       hasPasswordError = true;
  //       errorPasswordMessage = 'Минимальная длина 6 символов';
  //     } else if (e.code == 'too-many-requests') {
  //       tooManyRequestsError = true;
  //       errorMessage = 'Слишком много попыток. Попробуйте позже';
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future singIn(String email, String password) async {
    try {
      clearErrors();
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }  on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      hasError = true;
      if (e.code == 'user-not-found') {
        hasEmailError = true;
        errorEmailMessage = 'Пользователь не найден';
      } else if (e.code == 'wrong-password') {
        hasPasswordError = true;
        errorPasswordMessage = 'Неверный пароль';
      } else if (e.code == 'too-many-requests') {
        tooManyRequestsError = true;
        errorMessage = 'Слишком много попыток. Попробуйте позже';
      }
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  void clearErrors(){
    errorMessage = '';
    errorEmailMessage = '';
    errorPasswordMessage = '';
    hasError = false;
    hasEmailError = false;
    hasPasswordError = false;
    tooManyRequestsError = false;
  }
}
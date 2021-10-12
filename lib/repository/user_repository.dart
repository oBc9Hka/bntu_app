import 'package:bntu_app/repository/abstract/abstract_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirestoreRepository extends UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // var _firebaseAuthListen = FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  String errorMessage = '';
  String errorEmailMessage = '';
  String errorPasswordMessage = '';
  bool hasError = false;
  bool hasEmailError = false;
  bool hasPasswordError = false;
  bool tooManyRequestsError = false;
  CollectionReference dbRef = FirebaseFirestore.instance.collection('User');

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      _clearErrors();
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
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

  void _clearErrors() {
    errorMessage = '';
    errorEmailMessage = '';
    errorPasswordMessage = '';
    hasError = false;
    hasEmailError = false;
    hasPasswordError = false;
    tooManyRequestsError = false;
  }

  @override
  Future<User?> getCurrentUser() async {
    User? _user;
    // _firebaseAuth.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //     _user = user;
    //   }
    // });
    _user = _firebaseAuth.currentUser;
    return _user;
  }

  @override
  Map<String, dynamic> getErrors() {
    Map<String, dynamic> map = {
      'errorMessage': errorMessage,
      'errorEmailMessage': errorEmailMessage,
      'errorPasswordMessage': errorPasswordMessage,
      'hasError': hasError,
      'hasEmailError': hasEmailError,
      'hasPasswordError': hasPasswordError,
      'tooManyRequestsError': tooManyRequestsError,
    };
    return map;
  }
}

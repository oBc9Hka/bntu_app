// Mocks generated by Mockito 5.0.16 from annotations
// in bntu_app/test/repository/user_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bntu_app/core/repository/user_repository.dart' as _i3;
import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeCollectionReference_0<T extends Object?> extends _i1.Fake
    implements _i2.CollectionReference<T> {}

/// A class which mocks [UserFirestoreRepository].
///
/// See the documentation for Mockito's code generation for more information.
class BaseMockUserFirestoreRepository extends _i1.Mock
    implements _i3.UserFirestoreRepository {
  @override
  String get errorMessage =>
      (super.noSuchMethod(Invocation.getter(#errorMessage), returnValue: '')
          as String);
  @override
  set errorMessage(String? _errorMessage) =>
      super.noSuchMethod(Invocation.setter(#errorMessage, _errorMessage),
          returnValueForMissingStub: null);
  @override
  String get errorEmailMessage => (super
          .noSuchMethod(Invocation.getter(#errorEmailMessage), returnValue: '')
      as String);
  @override
  set errorEmailMessage(String? _errorEmailMessage) => super.noSuchMethod(
      Invocation.setter(#errorEmailMessage, _errorEmailMessage),
      returnValueForMissingStub: null);
  @override
  String get errorPasswordMessage =>
      (super.noSuchMethod(Invocation.getter(#errorPasswordMessage),
          returnValue: '') as String);
  @override
  set errorPasswordMessage(String? _errorPasswordMessage) => super.noSuchMethod(
      Invocation.setter(#errorPasswordMessage, _errorPasswordMessage),
      returnValueForMissingStub: null);
  @override
  bool get hasError =>
      (super.noSuchMethod(Invocation.getter(#hasError), returnValue: false)
          as bool);
  @override
  set hasError(bool? _hasError) =>
      super.noSuchMethod(Invocation.setter(#hasError, _hasError),
          returnValueForMissingStub: null);
  @override
  bool get hasEmailError =>
      (super.noSuchMethod(Invocation.getter(#hasEmailError), returnValue: false)
          as bool);
  @override
  set hasEmailError(bool? _hasEmailError) =>
      super.noSuchMethod(Invocation.setter(#hasEmailError, _hasEmailError),
          returnValueForMissingStub: null);
  @override
  bool get hasPasswordError =>
      (super.noSuchMethod(Invocation.getter(#hasPasswordError),
          returnValue: false) as bool);
  @override
  set hasPasswordError(bool? _hasPasswordError) => super.noSuchMethod(
      Invocation.setter(#hasPasswordError, _hasPasswordError),
      returnValueForMissingStub: null);
  @override
  bool get tooManyRequestsError =>
      (super.noSuchMethod(Invocation.getter(#tooManyRequestsError),
          returnValue: false) as bool);
  @override
  set tooManyRequestsError(bool? _tooManyRequestsError) => super.noSuchMethod(
      Invocation.setter(#tooManyRequestsError, _tooManyRequestsError),
      returnValueForMissingStub: null);
  @override
  _i2.CollectionReference<Object?> get dbRef =>
      (super.noSuchMethod(Invocation.getter(#dbRef),
              returnValue: _FakeCollectionReference_0<Object?>())
          as _i2.CollectionReference<Object?>);
  @override
  set dbRef(_i2.CollectionReference<Object?>? _dbRef) =>
      super.noSuchMethod(Invocation.setter(#dbRef, _dbRef),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> signUp(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#signUp, [email, password]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> signIn(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#signIn, [email, password]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i5.User?> getCurrentUser() =>
      (super.noSuchMethod(Invocation.method(#getCurrentUser, []),
          returnValue: Future<_i5.User?>.value()) as _i4.Future<_i5.User?>);
  @override
  Map<String, dynamic> getErrors() =>
      (super.noSuchMethod(Invocation.method(#getErrors, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
  @override
  String toString() => super.toString();
}

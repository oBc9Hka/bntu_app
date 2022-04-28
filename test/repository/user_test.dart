import 'package:bntu_app/core/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_test.mocks.dart';

class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User? get currentUser => _mockUser;
}

@GenerateMocks([], customMocks: [
  MockSpec<UserFirestoreRepository>(
    as: #BaseMockUserFirestoreRepository,
    returnNullOnMissingStub: true,
  ),
])
void main() {
  var _userRepo = BaseMockUserFirestoreRepository();

  group('Authentication tests', () {
    test('Get current user', () {
      expectLater(_userRepo.getCurrentUser(),
          _mockUser); // type 'Null' is not a subtype of type 'Future<User?>' in type cast
    });
  });
}

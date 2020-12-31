import 'package:Henfam/bloc/auth/auth_bloc.dart';
import 'package:Henfam/repository/repositories.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

// import 'package:flutter_login/authentication/authentication.dart';

class MockUserRepository extends Mock implements FirebaseUserRepository {}

void main() {
  AuthBloc authBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    authBloc = AuthBloc(userRepository: userRepository);
  });

  tearDown(() {
    authBloc?.close();
  });

  test('initial state is correct', () {
    expect(AuthBloc.initialState, Uninitialized());
  });

  test('close does not emit new states', () {
    expectLater(
      AuthBloc,
      emitsInOrder([Uninitialized(), emitsDone]),
    );
    // AuthBloc.close();
  });
}

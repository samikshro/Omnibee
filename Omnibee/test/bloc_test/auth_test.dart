import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/models/models.dart';
import 'package:Omnibee/repository/repositories.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements FirebaseUserRepository {}

void authBlocTests() {
  group('AuthBloc', () {
    AuthBloc authBloc;
    User mockUser;
    MockUserRepository userRepository;

    setUp(() {
      mockUser = User("", 0, 0, "", "", 0, 0, 0, "", "", true, "", 0);
      userRepository = MockUserRepository();
      authBloc = AuthBloc(userRepository: userRepository);
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => AuthBloc(userRepository: userRepository),
      expect: [],
    );

    blocTest(
      'AppStarted: emits [Unauthenticated()] when AppStarted added',
      build: () => authBloc,
      act: (AuthBloc bloc) async => bloc.add(AppStarted()),
      expect: [Unauthenticated()],
    );

    blocTest(
      'WasAuthenticated: emits [Authenticated(user)] when WasAuthenticated added',
      build: () => authBloc,
      act: (AuthBloc bloc) async =>
          bloc..add(AppStarted())..add(WasAuthenticated(mockUser)),
      expect: <AuthState>[
        Unauthenticated(),
        Authenticated(User("", 0, 0, "", "", 0, 0, 0, "", "", true, "", 0))
      ],
    );

    blocTest(
      'WasUnauthenticated: emits [Unauthenticated()] when WasUnauthenticated added',
      build: () => authBloc,
      act: (AuthBloc bloc) async => bloc
        ..add(AppStarted())
        ..add(WasAuthenticated(mockUser))
        ..add(WasUnauthenticated()),
      expect: <AuthState>[
        Unauthenticated(),
        Authenticated(User("", 0, 0, "", "", 0, 0, 0, "", "", true, "", 0)),
        Unauthenticated(),
      ],
    );

    blocTest(
      'SignedIn: emits [ErrorState(...)] when SignedIn added w/ null input',
      build: () => authBloc,
      act: (AuthBloc bloc) async =>
          bloc..add(AppStarted())..add(SignedIn("", "")),
      expect: <AuthState>[
        Unauthenticated(),
        ErrorState("Invalid login. Please try again."),
      ],
    );

    blocTest(
      'SignedIn: emits [ErrorState(...)] when SignedIn added w/ null input',
      build: () => authBloc,
      act: (AuthBloc bloc) async =>
          bloc..add(AppStarted())..add(SignedIn("", "")),
      expect: <AuthState>[
        Unauthenticated(),
        ErrorState("Invalid login. Please try again."),
      ],
    );

    tearDown(() {
      mockUser = null;
      authBloc?.close();
    });
  });
}

main() {
  ft.TestWidgetsFlutterBinding.ensureInitialized();
  authBlocTests();
}

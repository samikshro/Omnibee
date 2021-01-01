import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/models.dart';
import 'package:Henfam/repository/repositories.dart';
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
      mockUser = User("", 0, 0, "", "", 0, 0, 0, "", "", true);
      userRepository = MockUserRepository();
      // authBloc = AuthBloc(userRepository: FirebaseUserRepository());
      authBloc = AuthBloc(userRepository: userRepository);
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => AuthBloc(userRepository: userRepository),
      // AuthBloc(userRepository: FirebaseUserRepository()),
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
        Authenticated(User("", 0, 0, "", "", 0, 0, 0, "", "", true))
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
        Authenticated(User("", 0, 0, "", "", 0, 0, 0, "", "", true)),
        Unauthenticated(),
      ],
    );

    blocTest(
      'SignedIn: emits [Authenticated(user)] when SignedIn added',
      build: () => authBloc,
      act: (AuthBloc bloc) async =>
          bloc..add(AppStarted())..add(SignedIn("", "")),
      expect: <AuthState>[
        Unauthenticated(),
        Authenticated(null),
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

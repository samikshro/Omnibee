import 'dart:async';
import 'package:Henfam/exception/invalid_login.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Henfam/repository/repositories.dart';
import 'package:Henfam/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  StreamSubscription _userSubscription;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(Uninitialized());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is WasAuthenticated) {
      yield* _mapWasAuthenticatedToState(event);
    } else if (event is WasUnauthenticated) {
      yield* _mapWasUnauthenticatedToState(event);
    } else if (event is SignedIn) {
      yield* _mapSignedInToState(event);
    } else if (event is SignedUp) {
      yield* _mapSignedUpToState(event);
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isAuthenticated();
      if (!isSignedIn) {
        yield Unauthenticated();
      }
      final userId = await _userRepository.getUserId();
      _userSubscription?.cancel();
      _userSubscription = _userRepository.user(userId).listen(
            (user) => add(WasAuthenticated(user)),
          );
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapWasAuthenticatedToState(WasAuthenticated event) async* {
    yield Authenticated(event.user);
  }

  Stream<AuthState> _mapWasUnauthenticatedToState(
      WasUnauthenticated event) async* {
    if (state is Authenticated) {
      _userRepository.signOut();
    }
    yield Unauthenticated();
  }

  Stream<AuthState> _mapSignedInToState(SignedIn event) async* {
    if (state is Unauthenticated) {
      User user = await _userRepository.signIn(event.email, event.password);
      print(user);
      if (user != null) {
        yield Authenticated(user);
      } else {
        print("Yielding error state");
        yield ErrorState("Invalid login. Please try again.");
      }
    }
  }

  Stream<AuthState> _mapSignedUpToState(SignedUp event) async* {
    if (state is Unauthenticated) {
      try {
        List<String> signedUp = await _userRepository.signUp(
            event.name, event.email, event.password, event.phone);
        _mapSignedInToState(SignedIn(signedUp[0], signedUp[1]));
      } catch (e) {
        yield ErrorState("Invalid signup. Please try again.");
      }
    }
  }
}

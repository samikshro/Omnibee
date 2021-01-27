import 'dart:async';
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
    } else if (event is WasStripeSetupCompleted) {
      yield* _mapWasStripeSetupCompletedToState();
    } else if (event is UserUpdated) {
      yield* _mapUserUpdatedToState(event);
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      print("Before call to isAuthenticated");
      final isSignedIn = await _userRepository.isAuthenticated();
      print("isSignedIn is $isSignedIn");
      if (!isSignedIn) {
        yield Unauthenticated();
      }
      print("before call to to getUserId");
      final user = await _userRepository.getUser();
      print("userId is ${user.uid}");
      _userSubscription?.cancel();
      _userSubscription = _userRepository.user(user.uid).listen((updatedUser) {
        print("Adding wasAuthenticated event");
        add(UserUpdated(updatedUser));
      });
      yield Authenticated(user);
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapWasAuthenticatedToState(WasAuthenticated event) async* {
    yield Authenticated(event.user);
  }

  Stream<AuthState> _mapUserUpdatedToState(UserUpdated event) async* {
    yield Authenticated(event.user);
  }

  Stream<AuthState> _mapWasUnauthenticatedToState(
      WasUnauthenticated event) async* {
    if (state is Authenticated) {
      _userSubscription?.cancel();
      _userRepository.signOut();
    }
    yield Unauthenticated();
  }

  Stream<AuthState> _mapSignedInToState(SignedIn event) async* {
    if (state is Unauthenticated) {
      User user = await _userRepository.signIn(
        event.email,
        event.password,
      );
      if (user != null) {
        yield Authenticated(user);
      } else {
        yield ErrorState("Invalid login. Please try again.");
      }
    }
  }

  Stream<AuthState> _mapSignedUpToState(SignedUp event) async* {
    if (state is Unauthenticated) {
      try {
        await _userRepository.signUp(
          event.name,
          event.email,
          event.password,
          event.phone,
        );
        User user = await _userRepository.signIn(
          event.email,
          event.password,
        );
        yield Authenticated(user);
      } catch (e) {
        yield ErrorState("Invalid signup. Please try again.");
      }
    }
  }

  Stream<AuthState> _mapWasStripeSetupCompletedToState() async* {
    User user =
        await _userRepository.getUserWUID((state as Authenticated).user.uid);
    yield Authenticated(user);
  }

  @override
  Future<void> close() {
    print("auth_bloc: close");
    _userSubscription?.cancel();
    return super.close();
  }
}

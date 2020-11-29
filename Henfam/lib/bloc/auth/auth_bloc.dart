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
    yield Unauthenticated();
  }
}

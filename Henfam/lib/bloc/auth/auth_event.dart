part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class WasAuthenticated extends AuthEvent {
  final User user;

  WasAuthenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'WasAuthenticated { user: $user }';
}

class SignedIn extends AuthEvent {
  final String email;
  final String password;

  SignedIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignedIn { email: $email, password: $password }';
}

class SignedUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  SignedUp(this.name, this.email, this.password, this.phone);

  @override
  List<Object> get props => [name, email, password, phone];

  @override
  String toString() =>
      'SignedIn { name: $name, email: $email, password: $password, phone: $phone }';
}

class WasUnauthenticated extends AuthEvent {
  @override
  List<Object> get props => [];
}

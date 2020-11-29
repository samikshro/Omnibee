import 'dart:async';
import 'package:Henfam/models/models.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();

  Future<String> signIn(String email, String password);

  Future<String> signUp(
      String name, String email, String password, String phone);

  Future<void> signOut();

  Future<String> getUserId();

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Stream<User> user(String uid);
}

import 'dart:async';
import 'package:Henfam/models/models.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();

  Future<User> signIn(String email, String password);

  Future<List<String>> signUp(
      String name, String email, String password, String phone);

  Future<void> signOut();

  Future<String> getUserId();

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Stream<User> user(String uid);
}

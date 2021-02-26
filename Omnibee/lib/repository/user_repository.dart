import 'dart:async';
import 'package:Omnibee/models/models.dart';

abstract class UserRepository {
  Future<bool> isAuthenticated();

  Future<User> signIn(String email, String password);

  Future<List<String>> signUp(
      String name, String email, String password, String phone);

  Future<void> signOut();

  Future<void> incrementEarnings(User user, double amount);

  Future<String> getUserId();

  Future<User> getUser();

  Future<User> getUserWUID(String uid);

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Stream<User> user(String uid);

  Stream<bool> authStatus();
}

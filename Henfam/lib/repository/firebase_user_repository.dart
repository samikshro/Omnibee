import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'repositories.dart';
import 'package:Henfam/models/models.dart';
import 'package:Henfam/entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = Firestore.instance.collection('users');

  FirebaseUserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<bool> isAuthenticated() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fUser = result.user;
      User user = await userCollection
          .document(fUser.uid)
          .get()
          .then((DocumentSnapshot document) {
        return User.fromEntity(UserEntity.fromSnapshot(document));
      });
      return user;
    } catch (e) {}
  }

  @override
  Future<List<String>> signUp(
      String name, String email, String password, String phone) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;

    userCollection.document(user.uid).setData({
      'name': name,
      'email': email,
      'runs': 0,
      'requests': 0,
      'boosters': 0,
      'earnings': 0.0,
      'points': 0,
      'stripe_setup_complete': false,
      'stripeAccountId': "",
      'phone': phone,
      'token': "",
    });

    return [email, password];
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  @override
  Future<User> getUser() async {
    String uid = await getUserId();
    User user = await userCollection
        .document(uid)
        .get()
        .then((DocumentSnapshot document) {
      return User.fromEntity(UserEntity.fromSnapshot(document));
    });
    return user;
  }

  Future<User> getUserWUID(String uid) async {
    User user = await userCollection
        .document(uid)
        .get()
        .then((DocumentSnapshot document) {
      return User.fromEntity(UserEntity.fromSnapshot(document));
    });
    return user;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Stream<User> user(String uid) {
    /* return userCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList()
          .firstWhere((user) => user.uid == uid);
    }); */

    return userCollection
        .document(uid)
        .snapshots()
        .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)));
  }
}
